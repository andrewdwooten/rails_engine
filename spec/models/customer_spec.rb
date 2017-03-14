require 'rails_helper'

RSpec.describe Customer, type: :model do
  it "has many invoices" do
    customer = create(:customer)

    expect(customer).to respond_to(:invoices)
  end
end
