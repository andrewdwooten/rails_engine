FactoryGirl.define do
  factory :item do
    name "ItemName"
    description "ItemDescription"
    unit_price 1.5
    merchant Merchant.create()
  end
end
