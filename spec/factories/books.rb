FactoryBot.define do
  factory :book do
    sequence (:title) { |n| "№#{n} " + Faker::Book.title }
    author { Faker::Book.author }
    isbn { Faker::Code.unique.isbn }
    description { Faker::Lorem.paragraph }

    trait :empty_title do
      title { "" }
    end
  end
end
