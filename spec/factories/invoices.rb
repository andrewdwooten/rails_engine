FactoryGirl.define do
  factory :invoice do
    customer Customer.create()
    merchant Merchant.create()
    status "TestStatus"
  end
end
