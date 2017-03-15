require "rails_helper"

describe "Items API" do
  it "returns a collection of associated invoice items" do
    item = create(:item)
    invoice = create(:invoice)
    invoice_item = create(:invoice_item, item_id: item.id, invoice_id: invoice.id)
    get "/api/v1/items/#{item.id}/invoice_items"
    thing = JSON.parse(response.body)
    #byebug
    expect(response).to be_success
    expect(thing[0]["id"]).to eq(invoice_item.id)
  end

  it "returns the associated merchant" do
    merchant = create(:merchant)
    item = create(:item, merchant_id: merchant.id)
    invoice_item = create(:invoice_item, item_id: item.id)
    get "/api/v1/items/#{item.id}/merchant"
    thing = JSON.parse(response.body)

    expect(response).to be_success
    expect(thing["id"]).to eq(merchant.id)
  end
end
