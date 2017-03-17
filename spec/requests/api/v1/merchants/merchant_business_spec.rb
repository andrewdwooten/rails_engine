require "rails_helper"

describe "Merchant Business Intelligence" do
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

  it "returns total_revenue of all merchants on date" do
    merchant_1 = create(:merchant)
    merchant_2 = create(:merchant)
    item_good = create(:item, merchant: merchant_1)
    item_bad = create(:item, merchant: merchant_2)
    100.times do
      create(:invoice_item, item_id: item_good.id)
    end
    10.times do
      create(:invoice_item, item_id: item_bad.id)
    end

    Invoice.all.each do |invoice|
      invoice.update_attributes(created_at: "2012-03-16 11:55:05")
    end

    Invoice.all.each {|invoice| create(:transaction,
                                        invoice_id: invoice.id,
                                        result: "success")}

    get "/api/v1/merchants/revenue?date='2012-03-16 11:55:05'"
    expect(response).to be_success

    returned = JSON.parse(response.body)

    expect(returned.class).to eq(Hash)
    expect(returned["total_revenue"]).to eq("165.0")
  end

  #single
  xit "returns the total revenue for that merchant across all transactions" do
    merchant = create(:merchant)
    get "/api/v1/merchants/#{merchant.id}/revenue"
    thing = JSON.parse(response.body)

    expect(respone).to be_success
    expect(thing["revenue"]).to eq("000")
  end

  xit "returns the total revenue for date a across all merchants" do
    merchant = create(:merchant)
    item = create(:item, merchant: merchant.id)
    get "/api/v1/merchants/:id/revenue?date=x"
    thing = JSON.parse(response.body)

    expect(respone).to be_success
    expect(thing["total_revenue"]).to eq("000")
  end
end
