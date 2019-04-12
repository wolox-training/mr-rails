FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { Faker::Internet.password(9) }
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    locale { 'en' }
  end
end
