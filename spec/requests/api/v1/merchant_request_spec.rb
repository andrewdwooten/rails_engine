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
# =============
  it "finds a merchant by name" do
    merchant = create(:merchant)
    get "/api/v1/merchants/find?name=#{merchant.name}"
    thing = JSON.parse(response.body)
    expect(response).to be_success
    expect(thing["name"]).to eq(merchant.name)
  end
end
