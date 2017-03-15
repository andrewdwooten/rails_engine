require 'rails_helper'

describe "Merchant API" do
  it "displays all merchants" do
    create_list(:merchant, 8)
    get "/api/v1/merchants"

    expect(response).to be_success
  end

  it "displays a single merchant" do
    merchant = create(:merchant)
    get "/api/v1/merchants/#{merchant.id}"

    expect(response).to be_success
  end

  it "finds a merchant from parameters" do
    merchant = create(:merchant)
    get "/api/v1/merchants/find?id=#{merchant.id}"
    thing = JSON.parse(response.body)

    expect(response).to be_success
    expect(thing["id"]).to eq(merchant.id)
  end

  it "finds a merchant by name" do
    merchant = create(:merchant)
    get "/api/v1/merchants/find?name=#{merchant.name}"
    thing = JSON.parse(response.body)

    expect(response).to be_success
    expect(thing["id"]).to eq(merchant.id)
  end

  it "finds a merchant by created at" do
    merchant = create(:merchant,
                      created_at: "2012-03-27 14:54:09 UTC")
    get "/api/v1/merchants/find?created_at=#{merchant.created_at}"
    thing = JSON.parse(response.body)

    expect(response).to be_success
    expect(thing["id"]).to eq(merchant.id.as_json)
  end

  it "finds a merchant by updated at" do
    merchant = create(:merchant,
                      updated_at: "2012-03-27 14:54:09 UTC")
    get "/api/v1/merchants/find?updated_at=#{merchant.updated_at}"
    thing = JSON.parse(response.body)

    expect(response).to be_success
    expect(thing["id"]).to eq(merchant.id)
  end

  it "finds all matches when given name" do
    merchant = create(:merchant, name: "Derp")
    other_merchant = create(:merchant, name: "Derp")
    get "/api/v1/merchants/find_all?name=#{merchant.name}"
    thing = JSON.parse(response.body)

    expect(response).to be_success
    expect(thing[0]["id"]).to eq(merchant.id)
    expect(thing[1]["id"]).to eq(other_merchant.id)
  end

  it "finds all matches when given created_at" do
    merchant = create(:merchant,
                          name: "Lovely Lions",
                    created_at: "2012-03-27 14:54:09 UTC")

    other_merchant = create(:merchant,
                                name: "Tattered Book Cover",
                          created_at: "2012-03-27 14:54:09 UTC")
    get "/api/v1/merchants/find_all?created_at=#{merchant.created_at}"
    thing = JSON.parse(response.body)

    expect(response).to be_success
    expect(thing[0]["id"]).to eq(merchant.id)
    expect(thing[1]["id"]).to eq(other_merchant.id)
  end

  it "finds all matches when given name and created_at" do
    merchant = create(:merchant,
                      name: "Notderp",
                      updated_at: "2012-03-27 14:54:09 UTC")

    other_merchant = create(:merchant,
                            updated_at: "2012-03-27 14:54:09 UTC")
    get "/api/v1/merchants/find_all?updated_at=#{merchant.updated_at}"
    thing = JSON.parse(response.body)

    expect(response).to be_success
    expect(thing[0]["id"]).to eq(merchant.id)
    expect(thing[1]["id"]).to eq(other_merchant.id) # here too
  end

  it "returns a random resource for merchant" do
    merchant_one = create(:merchant, name: "Hiedi")
    merchant_two = create(:merchant, name: "Hildi")
    merchant_three = create(:merchant, name: "Harding")


    get "/api/v1/merchants/random"
    thing = JSON.parse(response.body)
    #require 'pry'; binding.pry
    expect(response).to be_success
    id = thing[0]["id"]
    merch = Merchant.find(id).id
    expect(thing[0]["id"]).to eq(merch)
  end
end
