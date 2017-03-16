require 'rails_helper'

describe 'Merchant Relationship endpoints' do
  it 'returns collection of items associated with a merchant' do
    merchant = create(:merchant)
    merchant.items.create(name: 'test1')
    merchant.items.create(name: 'test2')
    merchant.items.create(name: 'test3')

    get "/api/v1/merchants/#{merchant.id}/items"

    expect(response).to be_success

    merchant_items = JSON.parse(response.body)

    expect(merchant_items[0]["name"]).to eq('test1')
    expect(merchant_items[1]["name"]).to eq('test2')
    expect(merchant_items[2]["name"]).to eq('test3')

  end

  it 'returns collection of invoices associated with a merchant' do
    merchant = create(:merchant)
    customer = create(:customer)
    merchant.invoices.create(status: 'test1', customer_id: customer.id)
    merchant.invoices.create(status: 'test2', customer_id: customer.id)
    merchant.invoices.create(status: 'test3', customer_id: customer.id)

    get "/api/v1/merchants/#{merchant.id}/invoices"

    expect(response).to be_success

    merchant_invoices = JSON.parse(response.body)

    expect(merchant_invoices[0]["status"]).to eq('test1')
    expect(merchant_invoices[1]["status"]).to eq('test2')
    expect(merchant_invoices[2]["status"]).to eq('test3')
  end
end
