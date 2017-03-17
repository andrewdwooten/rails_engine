require "rails_helper"

describe "Transaction Relationship Endpoint" do
  it "returns invoice associated with a transaction" do
    transaction = create(:transaction)
    # transaction.invoice = create(:invoice)

    get "/api/v1/transactions/#{transaction.id}/invoice"

    expect(response).to be_success

    transaction_invoice = JSON.parse(response.body)

    expect(transaction_invoice["status"]).to eq("Teststatus")
  end
end
