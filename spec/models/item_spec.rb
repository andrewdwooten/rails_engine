require 'rails_helper'

RSpec.describe Item, type: :model do
  describe "relationships" do
    it "has relationship with invoice_items" do
      item = create(:item)

      expect(item).to respond_to(:invoice_items)
    end

    it "has relationship invoices" do
      item = create(:item)

      expect(item).to respond_to(:invoices)
    end
    
    it "has relationship with merchant" do
      item = create(:item)

      expect(item).to respond_to(:merchant)
    end
  end
end
