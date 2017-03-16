require 'rails_helper'

describe 'merchants returned ranked by revenue' do
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
end
