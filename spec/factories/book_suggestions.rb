FactoryBot.define do
  factory :book_suggestion do
    synopsis { Faker::Lorem.paragraph }
    price { Faker::Commerce.price }
    author { Faker::Book.author }
    title { Faker::Book.title }
    link { Faker::Internet.url }
    editor { Faker::Book.publisher }
    year { Faker::Number.between(1900, 2019) }
    user
  end
end
