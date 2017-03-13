FactoryGirl.define do
  factory :invoice_item do
    item Item.create()
    invoice Invoice.create()
    quantity 1
    unit_price 1.5
  end
end
