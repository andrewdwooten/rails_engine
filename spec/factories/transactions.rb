FactoryGirl.define do
  factory :transaction do
    invoice Invoice.create()
    credit_card_number "4678-1242-5324-1233"
    credit_card_expiration_date "03/2016"
    result "completed"
  end
end
