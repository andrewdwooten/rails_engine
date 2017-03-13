require 'rails_helper'

RSpec.describe Invoice, type: :model do
  describe "relationships" do
    it "has a relationship with a customer" do
      invoice = create(:invoice)

      expect(invoice).to respond_to(:customer)
    end

    it "has a relationship with a merchant" do
      invoice = create(:invoice)

      expect(invoice).to respond_to(:merchant)
    end

    it "has a relationship with items" do
      invoice = create(:invoice)

      expect(invoice).to respond_to(:items)
    end

    it "has a relationship with transactions" do
      invoice = create(:invoice)

      expect(invoice).to respond_to(:transactions)
    end
  end
end
