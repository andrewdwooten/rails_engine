FactoryGirl.define do
  factory :item do
    name "Hammer"
    description "Heavy shiny"
    unit_price 1.5
    merchant_id Merchant.create().id
  end
end
