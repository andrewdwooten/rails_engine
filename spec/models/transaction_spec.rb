require 'rails_helper'

RSpec.describe Transaction, type: :model do
  it "belongs to invoice" do
    trans = create(:transaction)

    expect(trans).to respond_to(:invoice)
  end
end
