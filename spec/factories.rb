FactoryBot.define do
  factory :user do
    first_name { 'Joe' }
    last_name { 'Monroy' }
    email { 'blahj@gmail.com' }
    cellphone { 3004585635 }
    address { 'Cra 45 #60-25' }
  end
end
