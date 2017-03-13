require 'rails_helper'

RSpec.describe InvoiceItem, type: :model do
  describe "relationships" do
    it "has a relationship with an item" do
      invoice_item = create(:invoice_item)

      expect(invoice_item).to respond_to(:item)
    end

    it "has a relationship with an invoice" do
      invoice_item = create(:invoice_item)

      expect(invoice_item).to respond_to(:invoice)
    end
  end
end
