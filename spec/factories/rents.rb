FactoryBot.define do
  factory :rent do
    user { Faker::Name.first_name }
    book { Faker::Book.title }
    rent_start { Faker::Date.today }
    rent_end { Faker::Date.today + 5 }
  end
end
