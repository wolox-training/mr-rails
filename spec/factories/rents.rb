FactoryBot.define do
  factory :rent do
    user
    book
    start_date { Faker::Date.backward(5) }
    end_date { Faker::Date.forward(5) }
  end
end
