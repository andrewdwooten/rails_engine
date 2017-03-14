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
      invoice = create(:invoice)

      get "/api/v1/invoices/find?status=#{invoice.status}"

      expect(response).to be_success

      invoice_json = JSON.parse(response.body)

      expect(invoice_json["status"]).to eq(invoice.status)
    end

    it "returns an invoice based on created at stamp" do
      invoice = create(:invoice,
                       created_at: "2012-03-27 14:54:09 UTC")

      get "/api/v1/invoices/find?created_at=#{invoice.created_at}"

      expect(response).to be_success

      invoice_json = JSON.parse(response.body)

      expect(invoice_json["created_at"]).to eq(invoice.created_at.as_json)
    end

    it "returns an invoice based on updated at stamp" do
      invoice = create(:invoice,
                       updated_at: "2012-03-27 14:54:09 UTC")

      get "/api/v1/invoices/find?updated_at=#{invoice.updated_at}"

      expect(response).to be_success

      invoice_json = JSON.parse(response.body)

      expect(invoice_json["updated_at"]).to eq(invoice.updated_at.as_json)
    end

    it "returns a random invoice" do
      create(:invoice)
      create(:invoice)


      get "/api/v1/invoices/random"

      expect(response).to be_success
      
      invoice_json = JSON.parse(response.body)[0]
      id = invoice_json["id"]
      expect(invoice_json["updated_at"]).to eq(Invoice.find(id)[:updated_at].as_json)
      expect(invoice_json["created_at"]).to eq(Invoice.find(id)[:created_at].as_json)
      expect(invoice_json["merchant_id"]).to eq(Invoice.find(id)[:merchant_id])
      expect(invoice_json["customer_id"]).to eq(Invoice.find(id)[:customer_id])
      expect(invoice_json["status"]).to eq(Invoice.find(id)[:status])
    end
end
