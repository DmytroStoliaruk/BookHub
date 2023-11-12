require "rails_helper"

RSpec.describe Book, type: :model do

  let(:invalid_book) { build(:book, :empty_title) }
  let!(:book) { create(:book, :with_cover, :with_content) }

  it { is_expected.to validate_presence_of(:title) }
  it { is_expected.to validate_presence_of(:author) }
  it { is_expected.to validate_presence_of(:isbn) }

  it "is not valid with an empty title" do
    expect(invalid_book).not_to be_valid
  end
  it "is expected to have attached cover and content" do
    expect(book.cover).to be_attached
    expect(book.content).to be_attached
  end

  describe "search" do
    
    # let!(:book1) { create(:book, :search_params1) }
    # let!(:book2) { create(:book, :search_params2) }
   
    context "when the books with title exists" do
      it "returns the books" do
        # results = BooksIndex.search("number")

        # search_results = query(query_string: {fields: [:title, :author, :description], query: "number"}).to_a
        # book_ids = search_results.map(&:id)
        # results= Book.where(id: book_ids)

        
        # search_results = BooksIndex.search("number").to_a
        # expect(search_results.size).to eq(2)


        # expect(results).to include(book1, book2)
        # expect(results.size).to eq(2)
      end
    end

    # context "when the books with author exists" do
    #   it "returns the books" do
    #     results = BooksIndex.search("Adams")
    #     expect(results.size).to eq(1)
    #     expect(results).to include(book2)
    #   end
    # end

    # context "when the books with description exists" do
    #   it "returns the books" do
    #     results = Book.search("About")
    #     expect(results.size).to eq(2)
    #     expect(results).to include(book1, book2)
    #   end
    # end

    # context "when the book does not exist" do
    #   it "returns no results" do
    #     results = Book.search("Some title")
    #     expect(results).to be_empty
    #   end
    # end
  end
end
