require 'rails_helper'

describe 'merchants favorite customer' do
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
