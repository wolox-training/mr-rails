FactoryBot.define do
  factory :book do
    genre { Faker::Book.genre }
    author { Faker::Book.author }
    image { Faker::Placeholdit.image }
    title { Faker::Book.title }
    editor { Faker::Book.publisher }
    year { Faker::Number.between(1900, 2019) }
  end
end
