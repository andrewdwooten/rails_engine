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

  it "finds a merchant by id" do
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
    expect(thing["name"]).to eq(merchant.name)
  end
#===========
  it "finds a merchant by created at" do
    merchant = create(:merchant)
    get "/api/v1/merchants/find?created_at=#{merchant.created_at}"
    thing = JSON.parse(response.body)
    expect(response).to be_success
    expect(thing["created_at"]).to eq(merchant.created_at.as_json)
  end

  xit "finds a merchant by updated at" do
    merchant = create(:merchant)
    get "/api/v1/merchants/find?updated_at=#{merchant.updated_at}"
    thing = JSON.parse(response.body)
    expect(response).to be_success
    expect(thing["updated_at"]).to eq(merchant.updated_at)
  end
#================

  xit "finds all matches when given name" do
    merchant = Merchant.create(name: "Lovely Lions",
                               created_at: "Tue, 14 Mar 2017 15:14:17 UTC +00:00")
    other_merchant = Merchant.create(name: "Derp")
    get "/api/v1/merchants/find_all?name=#{merchant.name}"
    thing = JSON.parse(response.body)
    expect(response).to be_success
    expect(thing["id"]).to eq(merchant.id)
    expect(thing["id"]).to eq(other_merchant.id)  #probably both not going to be id
  end

  xit "finds all matches when given created_at" do
    merchant = Merchant.create(name: "Lovely Lions",
                               created_at: "Tue, 14 Mar 2017 15:14:17 UTC +00:00")

    other_merchant = Merchant.create(name: "Tattered Book Cover",
                                     created_at: "Tue, 14 Mar 2017 15:14:17 UTC +00:00")
    get "/api/v1/merchants/find_all?created_at=#{merchant.created_at}"
    thing = JSON.parse(response.body)
    expect(response).to be_success
    expect(thing["created_at"]).to eq(merchant.created_at)
    expect(thing["created_at"]).to eq(other_merchant.created_at) # here too
  end

  xit "finds all matches when given name and created_at" do
    merchant = Merchant.create(name: "Lovely Lions",
                               updated_at: "Tue, 14 Mar 2017 15:14:17 UTC +00:00")

    other_merchant = Merchant.create(name: "Tattered Book Cover",
                                     updated_at: "Tue, 14 Mar 2017 15:14:17 UTC +00:00")
    get "/api/v1/merchants/find_all?updated_at=#{merchant.updated_at}"
    thing = JSON.parse(response.body)
    expect(response).to be_success
    expect(thing["updated_at"]).to eq(merchant.updated_at)
    expect(thing["updated_at"]).to eq(other_merchant.updated_at) # here too
  end
end
