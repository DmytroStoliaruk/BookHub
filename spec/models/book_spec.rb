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

  describe '.search' do
    let!(:book1) { create(:book, :book1_title) }
    let!(:book2) { create(:book, :book2_title) }

    before(:each) do
      Book.__elasticsearch__.create_index!(force: true)
      Book.import
      Book.__elasticsearch__.refresh_index!
    end

    context "when the books exists" do
      it "returns the books" do
        results = Book.search("number").records
        expect(results.size).to eq(2)
        expect(results).to include(book1, book2)
      end
    end

    context "when the book does not exist" do
      it "returns no results" do
        results = Book.search("Some title").records
        expect(results).to be_empty
      end
    end
  end
end
