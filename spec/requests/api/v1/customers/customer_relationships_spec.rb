require "rails_helper"

describe "Customer Relationship Endpoints" do
  it "returns collection of invoices associated with a customer" do
    customer = create(:customer)
    customer.invoices.create(status: "test1", merchant: create(:merchant))
    customer.invoices.create(status: "test2", merchant: create(:merchant))
    customer.invoices.create(status: "test3", merchant: create(:merchant))

    get "/api/v1/customers/#{customer.id}/invoices"

    expect(response).to be_success

    customer_invoices = JSON.parse(response.body)
    expect(customer_invoices[0]["status"]).to eq("test1")
    expect(customer_invoices[1]["status"]).to eq("test2")
    expect(customer_invoices[2]["status"]).to eq("test3")

  end

  it "returns collection of transactions associated with a customer" do
    customer = create(:customer)
    customer.invoices = create_list(:invoice, 2)
    transaction1 = create(:transaction, invoice: customer.invoices.first, result: "test1")
    transaction2 = create(:transaction, invoice: customer.invoices.last, result: "test2")

    get "/api/v1/customers/#{customer.id}/transactions"

    expect(response).to be_success

    customer_transactions = JSON.parse(response.body)

    expect(customer_transactions[0]["result"]).to eq("test1")
    expect(customer_transactions[1]["result"]).to eq("test2")
  end
end
