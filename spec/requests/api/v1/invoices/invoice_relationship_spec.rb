require 'rails_helper'

describe "Invoice API" do
  it "returns a collection of associated transactions" do
    invoice = create(:invoice)
    transaction = create(:transaction, invoice_id: invoice.id)
    get "/api/v1/invoices/#{invoice.id}/transactions"
    query = JSON.parse(response.body)

    expect(response).to be_success
    expect(query[0]["id"]).to eq(transaction.id)
  end

  it "returns a collection of associated invoice items" do
    invoice = create(:invoice)
    invoice_item = create(:invoice_item, invoice_id: invoice.id)
    get "/api/v1/invoices/#{invoice.id}/invoice_items"
    query = JSON.parse(response.body)

    expect(response).to be_success
    expect(query[0]["id"]).to eq(invoice_item.id)
  end

  it "returns a collection of associated items" do  #this test is a duplicate
    invoice = create(:invoice)
    item = create(:item)
    invoice_item = create(:invoice_item, item_id: item.id, invoice_id: invoice.id)
    get "/api/v1/invoices/#{invoice.id}/items"
    query = JSON.parse(response.body)

    expect(response).to be_success
    expect(query[0]["id"]).to eq(item.id)
  end

  it "returns the associated customer" do
    customer = create(:customer)
    invoice = create(:invoice, customer_id: customer.id)
    get "/api/v1/invoices/#{invoice.id}/customer"
    query = JSON.parse(response.body)

    expect(response).to be_success
    expect(query["id"]).to eq(customer.id)
  end

  it "returns the associated merchant" do
    merchant = create(:merchant)
    invoice = create(:invoice, merchant_id: merchant.id)
    get "/api/v1/invoices/#{invoice.id}/merchant"
    query = JSON.parse(response.body)

    expect(response).to be_success
    expect(query["id"]).to eq(merchant.id)
  end
end
