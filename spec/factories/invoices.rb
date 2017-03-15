FactoryGirl.define do
  factory :invoice do
    customer
    merchant 
    status "Teststatus"
  end
end
