FactoryBot.define do
  factory user = :user do
    first_name { 'Joe' }
    last_name { 'Monroy' }
    sequence(:email) { |n| "blah#{n}@gmail.com" }
    cellphone { 3004585635 }
    address { 'Cra 45 #60-25' }
  end

  factory :product do
    name { Faker::Food.fruits }
    description { Faker::Lorem.sentence }
    quantity { Faker::Number.number(digits: 1) }
    price { Faker::Number.decimal(l_digits: 3, r_digits: 3) }
    association :user, factory: [:user]
  end
end
