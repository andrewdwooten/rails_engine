require 'rails_helper'


describe "Invoices API" do
  it "sends a list of items" do
    create_list(:item, 3)

    get '/api/v1/items.json'

    expect(response).to be_success

    items = JSON.parse(response.body)

    expect(items.count).to eq(3)
  end

  it "sends a single item" do
    id = create(:item).id

    get "/api/v1/items/#{id}"

    expect(response).to be_success

    item_json = JSON.parse(response.body)

    expect(item_json["id"]).to eq(id)
    expect(item_json["name"]).to eq(Item.find(id).name)
    expect(item_json["merchant_id"]).to eq(Item.find(id).merchant_id)
    expect(item_json["description"]).to eq(Item.find(id).description)
    expect(item_json["unit_price"]).to eq(Item.find(id).unit_price.to_s)
  end

    it "returns an item based on merchant_id" do
      item = create(:item)

      get "/api/v1/items/find?merchant_id=#{item.merchant_id}"

      expect(response).to be_success

      item_json = JSON.parse(response.body)

      expect(item_json["merchant_id"]).to eq(item.merchant_id)
    end

    it "returns an item based on name" do
      item = create(:item)

      get "/api/v1/items/find?name=#{item.name}"

      expect(response).to be_success

      item_json = JSON.parse(response.body)

      expect(item_json["name"]).to eq(item.name)
    end

    it "returns an item based on description" do
      item = create(:item)

      get "/api/v1/items/find?description=#{item.description}"

      expect(response).to be_success

      item_json = JSON.parse(response.body)

      expect(item_json["description"]).to eq(item.description)
    end

    it "returns an item based on created at stamp" do
      item = create(:item,
                    created_at: "2012-03-27 14:54:09 UTC")

      get "/api/v1/items/find?created_at=#{item.created_at}"

      expect(response).to be_success

      item_json = JSON.parse(response.body)

      expect(item_json["id"]).to eq(item.id)
    end

    it "returns an item based on updated at stamp" do
      item = create(:item,
                    updated_at: "2012-03-27 14:54:09 UTC")

      get "/api/v1/items/find?updated_at=#{item.updated_at}"

      expect(response).to be_success

      item_json = JSON.parse(response.body)

      expect(item_json["id"]).to eq(item.id)
    end

    it "returns a random item" do
      create(:item)
      create(:item)


      get "/api/v1/items/random"

      expect(response).to be_success

      item_json = JSON.parse(response.body)[0]
      id = item_json["id"]
      expect(item_json["merchant_id"]).to eq(Item.find(id)[:merchant_id])
      expect(item_json["name"]).to eq(Item.find(id)[:name])
      expect(item_json["description"]).to eq(Item.find(id)[:description])
      expect(item_json["unit_price"]).to eq(Item.find(id)[:unit_price].to_s)
    end

    it "returns all items found by merchant_id" do
      create(:item,
              merchant_id: 1)
      create(:item,
              merchant_id: 1)

      get "/api/v1/items/find_all?merchant_id=1"

      expect(response).to be_success

      json_response = JSON.parse(response.body)
      expect(json_response[0]["merchant_id"]).to eq(1)
      expect(json_response[1]["merchant_id"]).to eq(1)
      expect(json_response.count).to eq(2)
    end

    it "returns all items found by name" do
      create(:item)
      create(:item)

      get "/api/v1/items/find_all?name=Hammer"

      expect(response).to be_success

      json_response = JSON.parse(response.body)
      expect(json_response[0]["name"]).to eq("Hammer")
      expect(json_response[1]["name"]).to eq("Hammer")
      expect(json_response.count).to eq(2)
    end

    it "returns all items found by description" do
      create(:item,
              description: 'Shiny')
      create(:item,
              description: 'Shiny')

      get "/api/v1/items/find_all?description=Shiny"

      expect(response).to be_success

      json_response = JSON.parse(response.body)
      expect(json_response[0]["description"]).to eq('Shiny')
      expect(json_response[1]["description"]).to eq('Shiny')
      expect(json_response.count).to eq(2)
    end

    it "returns all items found by created_at" do
      create(:item,
            created_at: "2012-03-27 14:54:09 UTC")
      create(:item,
            created_at: "2012-03-27 14:54:09 UTC")


      get "/api/v1/items/find_all?created_at=2012-03-27 14:54:09 UTC"

      expect(response).to be_success

      json_response = JSON.parse(response.body)
      expect(json_response[0]["name"]).to eq('Hammer')
      expect(json_response[1]["name"]).to eq('Hammer')
      expect(json_response.count).to eq(2)
    end

    it "returns all items found by updated at" do
      create(:item,
            updated_at: "2012-03-27 14:54:09 UTC")
      create(:item,
            updated_at: "2012-03-27 14:54:09 UTC")


      get "/api/v1/items/find_all?updated_at=2012-03-27 14:54:09 UTC"

      expect(response).to be_success

      json_response = JSON.parse(response.body)
      expect(json_response[0]["name"]).to eq('Hammer')
      expect(json_response[1]["name"]).to eq('Hammer')
      expect(json_response.count).to eq(2)
    end

    it "returns all items found by id" do
      id = create(:item).id
      create(:item)

      get "/api/v1/items/find_all?id=#{id}"

      expect(response).to be_success

      json_response = JSON.parse(response.body)
      expect(json_response[0]["name"]).to eq('Hammer')
      expect(json_response[0]["id"]).to eq(id)
      expect(json_response.count).to eq(1)
    end
end
