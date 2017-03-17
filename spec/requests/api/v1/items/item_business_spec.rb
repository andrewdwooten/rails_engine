require "rails_helper"

describe "Item Business Intelligence" do
  xit "API returns top (x)quantity items by revenue" do
    item_good = create(:item)
    item_bad = create(:item)
    100.times do
      create(:invoice_item, item_id: item_good.id)
    end
    10.times do
      create(:invoice_item, item_id: item_bad.id)
    end
    Invoice.all.each {|invoice| create(:transaction,
                                        invoice_id: invoice.id,
                                        result: "success")}

    get "/api/v1/items/most_revenue?quantity=2"

    expect(response).to be_success

    top_items = JSON.parse(response.body)

    expect(top_items[0]["id"]).to eq(item_good.id)
    expect(top_items[1]["id"]).to eq(item_bad.id)
  end
end
