require "rails_helper"

describe "Transaction API" do
  it "displays all transactions" do
    create_list(:transaction, 50)
    get "/api/v1/transactions"

    expect(response).to be_success
  end

  it "displays a single transaction" do
    transaction = create(:transaction)
    get "/api/v1/transactions/#{transaction.id}"

    expect(response).to be_success
  end

  it "finds a single record based on a when given an id" do
    transaction = create(:transaction)
    get "/api/v1/transactions/find?id=#{transaction.id}"
    query = JSON.parse(response.body)

    expect(response).to be_success
    expect(query["id"]).to eq(transaction.id)
  end

  it "finds a single record based on a when given a invoice_id" do
    invoice = create(:invoice)
    transaction = create(:transaction, invoice_id: invoice.id)
    get "/api/v1/transactions/find?invoice_id=#{transaction.invoice_id}"
    query = JSON.parse(response.body)

    expect(response).to be_success
    expect(query["invoice_id"]).to eq(transaction.invoice_id)
  end

  it "finds a single record based on a when given a credit_card_number" do
    transaction = create(:transaction)
    get "/api/v1/transactions/find?credit_card_number=#{transaction.credit_card_number}"
    query = JSON.parse(response.body)

    expect(response).to be_success
    expect(query["credit_card_number"]).to eq(transaction.credit_card_number)
  end

  it "finds a single record based on a when given a credit_card_expiration_date" do
    transaction = create(:transaction)
    get "/api/v1/transactions/find?credit_card_expiration_date=#{transaction.credit_card_expiration_date}"
    query = JSON.parse(response.body)

    expect(response).to be_success
    expect(query["credit_card_expiration_date"]).to eq(transaction.credit_card_expiration_date)
  end

  it "finds a single record based on a when given a result" do
    transaction = create(:transaction)
    get "/api/v1/transactions/find?result=#{transaction.result}"
    query = JSON.parse(response.body)

    expect(response).to be_success
    expect(query["result"]).to eq(transaction.result)
  end

  it "finds a single record based on a when given a created_at" do
    transaction = create(:transaction,
                      created_at: "2012-03-27 14:54:09 UTC")
    get "/api/v1/transactions/find?created_at=#{transaction.created_at}"
    query = JSON.parse(response.body)

    expect(response).to be_success
    expect(query["created_at"]).to eq(transaction.created_at.as_json)
  end

  it "finds a single record based on a when given a updated_at" do
    transaction = create(:transaction,
                      updated_at: "2012-03-27 14:54:09 UTC")
    get "/api/v1/transactions/find?updated_at=#{transaction.updated_at}"
    query = JSON.parse(response.body)

    expect(response).to be_success
    expect(query["updated_at"]).to eq(transaction.updated_at.as_json)
  end

  it "finds all matches with a given invoice_id" do
    invoice_one = create(:invoice)
    transaction_one = create(:transaction, invoice_id: invoice_one.id)
    transaction_two = create(:transaction, invoice_id: invoice_one.id)
    get "/api/v1/transactions/find_all?invoice_id=#{invoice_one.id}"
    query = JSON.parse(response.body)

    expect(response).to be_success
    expect(query[0]["invoice_id"]).to eq(transaction_one.invoice_id)
    expect(query[1]["invoice_id"]).to eq(transaction_two.invoice_id)
  end
  it "finds all matches with a given credit card number" do
    transaction_one = create(:transaction)
    transaction_two = create(:transaction)
    get "/api/v1/transactions/find_all?credit_card_number=4678-1242-5324-1233"
    query = JSON.parse(response.body)
    expect(response).to be_success
    expect(query[0]["credit_card_number"]).to eq(transaction_one.credit_card_number)
    expect(query[1]["credit_card_number"]).to eq(transaction_two.credit_card_number)
  end

  it "finds all matches with a given credit card expiration date" do
    transaction_one = create(:transaction, credit_card_expiration_date: "122018")
    transaction_two = create(:transaction, credit_card_expiration_date: "122018")
    get "/api/v1/transactions/find_all?credit_card_expiration_date=122018"
    query = JSON.parse(response.body)

    expect(response).to be_success
    expect(query[0]["credit_card_expiration_date"]).to eq(transaction_one.credit_card_expiration_date)
    expect(query[1]["credit_card_expiration_date"]).to eq(transaction_two.credit_card_expiration_date)
  end

  it "finds all matches with a given result" do
    transaction_one = create(:transaction, result: "completed")
    transaction_two = create(:transaction, result: "completed")
    get "/api/v1/transactions/find_all?result=completed"
    query = JSON.parse(response.body)

    expect(response).to be_success
    expect(query[0]["result"]).to eq(transaction_one.result)
    expect(query[1]["result"]).to eq(transaction_two.result)
  end

  it "finds all matches when given created_at" do
    transaction = create(:transaction,
                      created_at: "2012-03-27 14:54:09 UTC")

    other_transaction = create(:transaction,
                            created_at: "2012-03-27 14:54:09 UTC")
    get "/api/v1/transactions/find_all?created_at=#{transaction.created_at}"
    query = JSON.parse(response.body)

    expect(response).to be_success
    expect(query[0]["created_at"]).to eq(transaction.created_at.as_json)
    expect(query[1]["created_at"]).to eq(other_transaction.created_at.as_json)
  end

  it "finds all matches when given name and created_at" do
    transaction = create(:transaction,
                      updated_at: "2012-03-27 14:54:09 UTC")

    other_transaction = create(:transaction,
                            updated_at: "2012-03-27 14:54:09 UTC")
    get "/api/v1/transactions/find_all?updated_at=#{transaction.updated_at}"
    query = JSON.parse(response.body)

    expect(response).to be_success
    expect(query[0]["updated_at"]).to eq(transaction.updated_at.as_json)
    expect(query[1]["updated_at"]).to eq(other_transaction.updated_at.as_json) # here too
  end

  it "returns a random resource for transaction" do
    transaction_one = create(:transaction)
    transaction_two = create(:transaction)
    transaction_three = create(:transaction)

    get "/api/v1/transactions/random"
    query = JSON.parse(response.body)

    expect(response).to be_success
    id = query[0]["id"]
    transaction = Transaction.find(id).id

    expect(query[0]["id"]).to eq(transaction)
  end
end
