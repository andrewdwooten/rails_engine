require 'rails_helper'

describe "Invoice_items API" do
  it "sends a list of invoice_item" do
    create_list(:invoice_item, 3)

    get '/api/v1/invoice_items.json'

    expect(response).to be_success

    invoice_items = JSON.parse(response.body)

    expect(invoice_items.count).to eq(3)
  end

  it "sends a single invoice_item" do
    id = create(:invoice_item).id

    get "/api/v1/invoice_items/#{id}"

    expect(response).to be_success

    invoice_item_json = JSON.parse(response.body)

    expect(invoice_item_json["id"]).to eq(id)
    expect(invoice_item_json["item_id"]).to eq(InvoiceItem.find(id).item_id)
    expect(invoice_item_json["invoice_id"]).to eq(InvoiceItem.find(id).invoice_id)
    expect(invoice_item_json["quantity"]).to eq(InvoiceItem.find(id).quantity)
    expect(invoice_item_json["unit_price"]).to eq(InvoiceItem.find(id).unit_price.to_s)
  end

    it "returns an invoice_item based on item_id" do
      invoice_item = create(:invoice_item)

      get "/api/v1/invoice_items/find?item_id=#{invoice_item.item_id}"

      expect(response).to be_success

      invoice_item_json = JSON.parse(response.body)

      expect(invoice_item_json["item_id"]).to eq(invoice_item.item_id)
    end

    it "returns an invoice_item based on id" do
      invoice_item = create(:invoice_item)

      get "/api/v1/invoice_items/find?id=#{invoice_item.id}"

      expect(response).to be_success

      item_json = JSON.parse(response.body)

      expect(item_json["id"]).to eq(invoice_item.id)
    end

    it "returns an invoice_item based on invoice_id" do
      invoice_item = create(:invoice_item)

      get "/api/v1/invoice_items/find?invoice_id=#{invoice_item.invoice_id}"

      expect(response).to be_success

      invoice_item_json = JSON.parse(response.body)

      expect(invoice_item_json["invoice_id"]).to eq(invoice_item.invoice_id)
    end

    it "returns an invoice_item based on quantity" do
      invoice_item = create(:invoice_item)

      get "/api/v1/invoice_items/find?quantity=#{invoice_item.quantity}"

      expect(response).to be_success

      invoice_item_json = JSON.parse(response.body)

      expect(invoice_item_json["quantity"]).to eq(invoice_item.quantity)
    end

    it "returns an invoice_item based on unit_price" do
      invoice_item = create(:invoice_item)

      get "/api/v1/invoice_items/find?unit_price=#{invoice_item.unit_price}"

      expect(response).to be_success

      invoice_item_json = JSON.parse(response.body)

      expect(invoice_item_json["unit_price"]).to eq(invoice_item.unit_price.to_s)
    end

    it "returns an invoice_item based on created at stamp" do
      invoice_item = create(:invoice_item,
                    created_at: "2012-03-27 14:54:09 UTC")

      get "/api/v1/invoice_items/find?created_at=#{invoice_item.created_at}"

      expect(response).to be_success

      invoice_item_json = JSON.parse(response.body)

      expect(invoice_item_json["id"]).to eq(invoice_item.id)
    end

    it "returns an invoice_item based on updated at stamp" do
      invoice_item = create(:invoice_item,
                    updated_at: "2012-03-27 14:54:09 UTC")

      get "/api/v1/invoice_items/find?updated_at=#{invoice_item.updated_at}"

      expect(response).to be_success

      invoice_item_json = JSON.parse(response.body)

      expect(invoice_item_json["id"]).to eq(invoice_item.id)
    end

    it "returns a random invoice_item" do
      create(:invoice_item)
      create(:invoice_item)


      get "/api/v1/invoice_items/random"

      expect(response).to be_success

      invoice_item_json = JSON.parse(response.body)[0]
      id = invoice_item_json["id"]
      expect(invoice_item_json["invoice_id"]).to eq(InvoiceItem.find(id)[:invoice_id])
      expect(invoice_item_json["item_id"]).to eq(InvoiceItem.find(id)[:item_id])
      expect(invoice_item_json["quantity"]).to eq(InvoiceItem.find(id)[:quantity])
      expect(invoice_item_json["unit_price"]).to eq(InvoiceItem.find(id)[:unit_price].to_s)
    end

    it "returns all invoice_items found by item_id" do
      id = create(:item).id
      create(:invoice_item,
              item_id: id)
      create(:invoice_item,
              item_id: id)

      get "/api/v1/invoice_items/find_all?item_id=#{id}"

      expect(response).to be_success

      json_response = JSON.parse(response.body)
      expect(json_response[0]["item_id"]).to eq(id)
      expect(json_response[1]["item_id"]).to eq(id)
      expect(json_response.count).to eq(2)
    end

    it "returns all invoice_items found by invoice_id" do
      id = create(:invoice).id
      create(:invoice_item,
              invoice_id: id)
      create(:invoice_item,
              invoice_id: id)

      get "/api/v1/invoice_items/find_all?invoice_id=#{id}"

      expect(response).to be_success

      json_response = JSON.parse(response.body)
      expect(json_response[0]["invoice_id"]).to eq(id)
      expect(json_response[1]["invoice_id"]).to eq(id)
      expect(json_response.count).to eq(2)
    end

    it "returns all invoice_items found by quantity" do
      create(:invoice_item,
              quantity: 4)
      create(:invoice_item,
              quantity: 4)

      get "/api/v1/invoice_items/find_all?quantity=4"

      expect(response).to be_success

      json_response = JSON.parse(response.body)
      expect(json_response[0]["quantity"]).to eq(4)
      expect(json_response[1]["quantity"]).to eq(4)
      expect(json_response.count).to eq(2)
    end

    it "returns all invoice_items found by created_at" do
      create(:invoice_item,
              quantity: 37,
            created_at: "2012-03-27 14:54:09 UTC")
      create(:invoice_item,
             quantity: 93,
            created_at: "2012-03-27 14:54:09 UTC")


      get "/api/v1/invoice_items/find_all?created_at=2012-03-27 14:54:09 UTC"

      expect(response).to be_success

      json_response = JSON.parse(response.body)
      expect(json_response[0]["quantity"]).to eq(37)
      expect(json_response[1]["quantity"]).to eq(93)
      expect(json_response.count).to eq(2)
    end

    it "returns all invoice_items found by updated at" do
      create(:invoice_item,
              quantity: 18,
            updated_at: "2012-03-27 14:54:09 UTC")
      create(:invoice_item,
              quantity: 34,
            updated_at: "2012-03-27 14:54:09 UTC")


      get "/api/v1/invoice_items/find_all?updated_at=2012-03-27 14:54:09 UTC"

      expect(response).to be_success

      json_response = JSON.parse(response.body)
      expect(json_response[0]["quantity"]).to eq(18)
      expect(json_response[1]["quantity"]).to eq(34)
      expect(json_response.count).to eq(2)
    end

    it "returns all invoice_items found by id" do
      id = create(:invoice_item,
                  quantity: 38).id
      create(:invoice_item,
              quantity: 76)

      get "/api/v1/invoice_items/find_all?id=#{id}"

      expect(response).to be_success

      json_response = JSON.parse(response.body)
      expect(json_response[0]["quantity"]).to eq(38)
      expect(json_response[0]["id"]).to eq(id)
      expect(json_response.count).to eq(1)
    end
end
