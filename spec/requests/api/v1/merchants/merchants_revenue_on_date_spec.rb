require 'rails_helper'

describe 'merchants revenue on date query' do
  it 'returns total_revenue of all merchants on date' do
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

    get '/api/v1/merchants/revenue?date="2012-03-16 11:55:05"'

    expect(response).to be_success

    returned = JSON.parse(response.body)

    expect(returned.class).to eq(Hash)
    expect(returned["total_revenue"]).to eq("165.0")
  end
end
