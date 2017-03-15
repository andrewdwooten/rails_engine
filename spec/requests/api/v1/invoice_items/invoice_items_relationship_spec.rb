require "rails_helper"

describe "Invoice Items API" do
  it "returns the associated invoice" do
    invoice = create(:invoice)
    invoice_item = create(:invoice_item, invoice_id: invoice.id)
    get "/api/v1/invoice_items/#{invoice_item.id}/invoice"
    thing = JSON.parse(response.body)

    expect(response).to be_success
    expect(thing["id"]).to eq(invoice.id)
  end

  it "returns the associated item" do
    item = create(:item)
    invoice_item = create(:invoice_item, item_id: item.id)
    get "/api/v1/invoice_items/#{invoice_item.id }/item"
    thing = JSON.parse(response.body)

    expect(response).to be_success
    expect(thing["id"]).to eq(item.id)
  end
end
