require "rails_helper"

describe "Merchant API" do
  #multiple
  it "returns the top merchants ranked by total revenue" do
    merchant = create(:merchant)
    get "/api/v1/merchants/most_items?quantity=x"
    thing = JSON.parse(response.body)

    expect(respone).to be_success
    expect(thing["revenue"]).to eq("000")
  end

  xit "returns the total revenue for date a across all merchants" do
    merchant = create(:merchant)
    get "/api/v1/merchants/revenue?date=x"
    thing = JSON.parse(response.body)

    expect(respone).to be_success
    expect(thing["revenue"]).to eq("000")
  end

  #single
  xit "returns the total revenue for that merchant across all transactions" do
    merchant = create(:merchant)
    get "/api/v1/merchants/#{merchant.id}/revenue"
    thing = JSON.parse(response.body)

    expect(respone).to be_success
    expect(thing["revenue"]).to eq("000")
  end
end
