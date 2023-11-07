FactoryBot.define do
  factory :book do
    title { Faker::Book.title }
    author { Faker::Book.author }
    isbn { Faker::Code.unique.isbn }
    description { Faker::Lorem.paragraph }

    trait :empty_title do
      title { "" }
    end

    trait :with_cover do
      after(:create) do |book|
        cover_path = Rails.root.join("app", "assets", "images", "book_cover.png")
        book.cover.attach(io: File.open(cover_path),
                          filename: "book_cover.png",
                          content_type: "image/jpeg")
      end
    end

    trait :with_content do
      after(:create) do |book|
        content_path = Rails.root.join("app", "assets", "book_content", "ruby-tutorial.pdf")
        book.content.attach(io: File.open(content_path),
                          filename: "ruby-tutorial.pdf",
                          content_type: "application/pdf")
      end
    end
  end
end
