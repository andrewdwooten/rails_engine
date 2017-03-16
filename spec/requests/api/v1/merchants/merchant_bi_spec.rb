require "rails_helper"

describe "Merchant API" do
  #multiple
  it "returns the x amount of top merchants with the most items sold" do
    merchant_one = create(:merchant)
    merchant_two = create(:merchant)
    invoice_one = create(:invoice, merchant_id: merchant_one.id)
    invoice_two = create(:invoice, merchant_id: merchant_two.id)
    invoice_item = create_list(:invoice_item, 8, invoice_id: invoice_one.id)
    invoice_item = create_list(:invoice_item, 4, invoice_id: invoice_two.id)
    get "/api/v1/merchants/most_items?quantity=2"
    thing = JSON.parse(response.body)

    expect(response).to be_success
    expect(thing[0]["id"]).to eq(merchant_one.id)
  end

  it "returns the total revenue for date a across all merchants" do
    merchant = create(:merchant)
    get "/api/v1/merchants/revenue?date=12-13"
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
