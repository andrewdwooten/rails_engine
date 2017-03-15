require 'rails_helper'

describe "Invoice API" do
  it "returns a collection of associated transactions" do
    invoice = create(:invoice)
    #create_list(:transaction, 8)
    get "/api/v1/invoices/#{invoice.id}/transactions"

    expect(response).to be_success


  end

  xit "returns a collection of associated invoice items" do
    invoice = create(:invoice)
    get '/api/v1/invoices/#{invoice.id}/invoice_items'

    expect(response).to be_success


  end

  xit "returns a collection of associated items" do
    invoice = create(:invoice)
    get '/api/v1/invoices/#{invoice.id}/items'

    expect(response).to be_success


  end

  xit "returns the associated customer" do
    invoice = create(:invoice)
    get '/api/v1/invoices/#{invoice.id}/customer'

    expect(response).to be_success


  end

  xit "returns the associated merchant" do
    invoice = create(:invoice)
    get '/api/v1/invoices/#{invoice.id}/merchant'

    expect(response).to be_success


  end
end
