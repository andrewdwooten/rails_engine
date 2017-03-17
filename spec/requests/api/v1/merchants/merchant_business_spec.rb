require "rails_helper"

describe "Merchant Business Intelligence" do
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

  it 'returns collection of merchants ordered by revenue' do
      merchant_1 = create(:merchant)
      merchant_2 = create(:merchant)
      merchant_3 = create(:merchant)
      item_good = create(:item, merchant: merchant_1)
      item_bad = create(:item, merchant: merchant_2)
      customer = create(:customer)
      100.times do
        create(:invoice, merchant: merchant_1)
      end
      100.times do
        count = 1
        create(:invoice_item, item_id: item_good.id, invoice_id: Invoice.all[count].id)
        count +=1
      end

      Invoice.all.each {|invoice| create(:transaction,
                                          invoice: invoice,
                                          result: "success")}

      get '/api/v1/merchants/most_revenue?quantity=1'

      expect(response).to be_success

      ranked_merchants = JSON.parse(response.body)
      expect(ranked_merchants[0]["id"]).to eq(merchant_1.id)
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

  it "returns the total revenue for that merchant across all transactions" do
    merchant = create(:merchant)
    get "/api/v1/merchants/#{merchant.id}/revenue"
    thing = JSON.parse(response.body)

    expect(respone).to be_success
    expect(thing["revenue"]).to eq("000")
  end

  it 'returns customer who spends most with a given merchant' do
      merchant_1 = create(:merchant)

      item_good = create(:item, merchant: merchant_1)
      customer = create(:customer)
      customer_2 = create(:customer)
      invoices = []
      10.times do
        invoices <<  create(:invoice, merchant: merchant_1, customer: customer )
        end
      invoices.each do |invoice|
        create(:invoice_item, item_id: item_good.id, invoice: invoice)
      end

      invoices.each do |invoice|
        create(:transaction, invoice: invoice, result: "success")
      end

      Invoice.all.each {|invoice| create(:transaction,
                                          invoice: invoice,
                                          result: "success")}

      get "/api/v1/merchants/#{merchant_1.id}/favorite_customer"

      expect(response).to be_success

      favorite = JSON.parse(response.body)
      expect(favorite["id"]). to eq(customer.id)
      expect(favorite["first_name"]). to eq(customer.first_name)
      expect(favorite["last_name"]). to eq(customer.last_name)
  end
end
