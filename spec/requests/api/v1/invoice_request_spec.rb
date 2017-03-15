require 'rails_helper'

describe "Invoices API" do
  it "sends a list of invoices" do
    create_list(:invoice, 3)

    get '/api/v1/invoices.json'

    expect(response).to be_success

    invoices = JSON.parse(response.body)

    expect(invoices.count).to eq(3)
  end

  it "sends a single invoice" do
    id = create(:invoice).id

    get "/api/v1/invoices/#{id}"

    expect(response).to be_success

    invoice_json = JSON.parse(response.body)

    expect(invoice_json["id"]).to eq(id)
    expect(invoice_json["customer_id"]).to eq(Invoice.find(id).customer_id)
    expect(invoice_json["merchant_id"]).to eq(Invoice.find(id).merchant_id)
  end

    it "returns an invoice based on merchant_id" do
      invoice = create(:invoice)

      get "/api/v1/invoices/find?merchant_id=#{invoice.merchant_id}"

      expect(response).to be_success

      invoice_json = JSON.parse(response.body)

      expect(invoice_json["merchant_id"]).to eq(invoice.merchant_id)
    end

    it "returns an invoice based on customer_id" do
      invoice = create(:invoice)

      get "/api/v1/invoices/find?customer_id=#{invoice.customer_id}"

      expect(response).to be_success

      invoice_json = JSON.parse(response.body)

      expect(invoice_json["customer_id"]).to eq(invoice.customer_id)
    end

    it "returns an invoice based on status" do
      invoice = create(:invoice,
                        status: 'test')

      get "/api/v1/invoices/find?status=#{invoice.status}"

      expect(response).to be_success

      invoice_json = JSON.parse(response.body)

      expect(invoice_json["status"]).to eq('test')
    end

    it "returns an invoice based on created at stamp" do
      invoice = create(:invoice,
                       created_at: "2012-03-27 14:54:09 UTC")

      get "/api/v1/invoices/find?created_at=#{invoice.created_at}"

      expect(response).to be_success

      invoice_json = JSON.parse(response.body)

      expect(invoice_json["id"]).to eq(invoice.id)
    end

    it "returns an invoice based on updated at stamp" do
      invoice = create(:invoice,
                       updated_at: "2012-03-27 14:54:09 UTC")

      get "/api/v1/invoices/find?updated_at=#{invoice.updated_at}"

      expect(response).to be_success

      invoice_json = JSON.parse(response.body)

      expect(invoice_json["id"]).to eq(invoice.id)
    end

    it "returns a random invoice" do
      create(:invoice)
      create(:invoice)


      get "/api/v1/invoices/random"

      expect(response).to be_success

      invoice_json = JSON.parse(response.body)[0]
      id = invoice_json["id"]
      expect(invoice_json["merchant_id"]).to eq(Invoice.find(id)[:merchant_id])
      expect(invoice_json["customer_id"]).to eq(Invoice.find(id)[:customer_id])
      expect(invoice_json["status"]).to eq(Invoice.find(id)[:status])
    end

    it "returns all invoices found by customer_id" do
      customer = create(:customer)
      invoices = create_list(:invoice, 2)
      customer.invoices << invoices


      get "/api/v1/invoices/find_all?customer_id=#{customer.id}"

      expect(response).to be_success

      json_response = JSON.parse(response.body)
      expect(json_response[0]["customer_id"]).to eq(customer.id)
      expect(json_response[1]["customer_id"]).to eq(customer.id)
      expect(json_response.count).to eq(2)
    end

    it "returns all invoices found by merchant_id" do
      create(:invoice,
              merchant_id: 1)
      create(:invoice,
              merchant_id: 1)

      get "/api/v1/invoices/find_all?merchant_id=1"

      expect(response).to be_success

      json_response = JSON.parse(response.body)
      expect(json_response[0]["merchant_id"]).to eq(1)
      expect(json_response[1]["merchant_id"]).to eq(1)
      expect(json_response.count).to eq(2)
    end

    it "returns all invoices found by status" do
      create(:invoice,
              status: 'test')
      create(:invoice,
              status: 'test')

      get "/api/v1/invoices/find_all?status=test"

      expect(response).to be_success

      json_response = JSON.parse(response.body)
      expect(json_response[0]["status"]).to eq('test')
      expect(json_response[1]["status"]).to eq('test')
      expect(json_response.count).to eq(2)
    end

    it "returns all invoices found by created_at" do
      create(:invoice,
            created_at: "2012-03-27 14:54:09 UTC")
      create(:invoice,
            created_at: "2012-03-27 14:54:09 UTC")


      get "/api/v1/invoices/find_all?created_at=2012-03-27 14:54:09 UTC"

      expect(response).to be_success

      json_response = JSON.parse(response.body)
      expect(json_response[0]["status"]).to eq('Teststatus')
      expect(json_response[1]["status"]).to eq('Teststatus')
      expect(json_response.count).to eq(2)
    end

    it "returns all invoices found by updated at" do
      create(:invoice,
            updated_at: "2012-03-27 14:54:09 UTC")
      create(:invoice,
            updated_at: "2012-03-27 14:54:09 UTC")


      get "/api/v1/invoices/find_all?updated_at=2012-03-27 14:54:09 UTC"

      expect(response).to be_success

      json_response = JSON.parse(response.body)
      expect(json_response[0]["status"]).to eq('Teststatus')
      expect(json_response[1]["status"]).to eq('Teststatus')
      expect(json_response.count).to eq(2)
    end
end
