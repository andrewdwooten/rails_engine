require "rails_helper"

describe "Item Business Intelligence" do
  it "API returns top (x)quantity items by revenue" do
    item_good = create(:item)
    item_bad = create(:item)
    100.times do
      create(:invoice_item, item_id: item_good.id)
    end
    10.times do
      create(:invoice_item, item_id: item_bad.id)
    end
    Invoice.all.each {|invoice| create(:transaction,
                                        invoice_id: invoice.id,
                                        result: "success")}

    get "/api/v1/items/most_revenue?quantity=2"

    expect(response).to be_success

    top_items = JSON.parse(response.body)

    expect(top_items[0]["id"]).to eq(item_good.id)
    expect(top_items[1]["id"]).to eq(item_bad.id)
  end

  it "returns date where most of item was sold" do
    merchant_1 = create(:merchant)
    item_good = create(:item, merchant: merchant_1)
    customer = create(:customer)
    invoices = []
    invoices_2 = []
    10.times do
      invoices <<  create(:invoice, merchant: merchant_1, customer: customer, created_at: "2013-03-27 14:54:09 UTC" )
      end
    5.times do
      invoices_2 <<  create(:invoice, merchant: merchant_1, customer: customer, created_at: "2012-03-27 14:54:09 UTC" )
      end
    invoices.each do |invoice|
      create(:invoice_item, item_id: item_good.id, invoice: invoice)
    end
    invoices_2.each do |invoice|
      create(:invoice_item, item_id: item_good.id, invoice: invoice)
    end

    Invoice.all.each do |invoice|
      create(:transaction, invoice: invoice, result: "success")
    end

    get "/api/v1/items/#{item_good.id}/best_day"

    expect(response).to be_success

    best_day = JSON.parse(response.body)

    expect(best_day["best_day"]).to eq("2013-03-27T14:54:09.000Z")

  end

  it "returns top selling items based on quantity given" do
    merchant_1 = create(:merchant)
    item_good = create(:item, merchant: merchant_1)
    item_less_good = create(:item, merchant: merchant_1)
    customer = create(:customer)
    invoices = []
    invoices_2 = []
    10.times do
      invoices <<  create(:invoice, merchant: merchant_1, customer: customer, created_at: "2013-03-27 14:54:09 UTC" )
      end
    5.times do
      invoices_2 <<  create(:invoice, merchant: merchant_1, customer: customer, created_at: "2012-03-27 14:54:09 UTC" )
      end
    invoices.each do |invoice|
      create(:invoice_item, item_id: item_good.id, invoice: invoice)
    end
    invoices_2.each do |invoice|
      create(:invoice_item, item_id: item_less_good.id, invoice: invoice)
    end

    Invoice.all.each do |invoice|
      create(:transaction, invoice: invoice, result: "success")
    end

    get "/api/v1/items/most_items?quantity=2"

    expect(response).to be_success

    top_items = JSON.parse(response.body)

    expect(top_items[0]["id"]).to eq(item_good.id)
    expect(top_items[1]["id"]).to eq(item_less_good.id)
  end
end
