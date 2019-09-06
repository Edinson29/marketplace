# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'faker'

15.times do
  user = User.create(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: Faker::Internet.email,
    cellphone: Faker::Number.number(digits: 10),
    address: Faker::Address.city
  )
  Product.create(
    name: Faker::Food.vegetables,
    description: Faker::Lorem.sentence,
    quantity: Faker::Number.number(digits: 1),
    price: Faker::Number.decimal(l_digits: 3, r_digits: 3),
    user_id: user.id
  )
end
