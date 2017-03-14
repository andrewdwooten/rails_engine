# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

STATUS = ["Ordered", "Shipped", "Paid", "Cancelled"]
  4843.times do
    Customer.create(first_name: Faker::Name.first_name,
                    last_name: Faker::Name.last_name)
  end

  4843.times do
    Merchant.create(name: Faker::Company.name)
  end
  4843.times do
    Invoice.create(customer_id: Faker::Number.between(1, 4843),
                   merchant_id: Faker::Number.between(1, 4843),
                   status: STATUS.sample)
  end
  2483.times do
    Item.create(name: Faker::Name.first_name,
                description: Faker::Name.first_name,
                unit_price: Faker::Number.between(1, 20),
                merchant_id: Faker::Number.between(1, 4843))
  end
