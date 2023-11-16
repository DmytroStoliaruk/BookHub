FactoryBot.define do
  factory :book do
    title { Faker::Book.title }
    author { Faker::Book.author }
    isbn { Faker::Code.unique.isbn }
    description { Faker::Lorem.paragraph }

    trait :empty_title do
      title { "" }
    end

    trait :search_params1 do
      title { "Book number one" }
      author { "John Smith" }
      description { "About nature" }
    end

    trait :search_params2 do
      title { "Book number two" }
      author { "Sara Adams" }
      description { "About furure" }
    end

    trait :with_cover do
      cover { Rack::Test::UploadedFile.new("app/assets/images/book_cover.png", "image/jpeg") }
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
