FactoryBot.define do
  factory :user do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    email { Faker::Internet.email }
    password { 'solosolo' }
    password_confirmation { 'solosolo' }
    cellphone { Faker::Number.number(digits: 10) }
    address { Faker::Address.city }
  end

  factory :product do
    name { Faker::Food.fruits }
    description { Faker::Lorem.sentence }
    quantity { Faker::Number.number(digits: 1) }
    price { Faker::Number.decimal(l_digits: 3, r_digits: 3) }
    user
    category
  end

  factory :category do
    name { Faker::Team.state }
  end
end
