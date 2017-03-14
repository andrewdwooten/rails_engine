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
    get "/api/v1/merchants/find?id=##{merchant.id}"

    expect(response.body).to_contain(merchant.name) 
  end
end
