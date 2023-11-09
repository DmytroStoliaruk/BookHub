require "rails_helper"

RSpec.describe Book, type: :model do
  let(:invalid_book) { build(:book, :empty_title) }
  let(:book) { create(:book, :with_cover, :with_content) }

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
    let(:index_name) { 'books_test' }
    let(:alias_name) { 'books_test_alias' } # Use a unique alias name

    before(:each) do
      Book.__elasticsearch__.create_index!(force: true)
      Book.import
      Book.__elasticsearch__.refresh_index!
    end

    before do
      # Ensure no conflicting index or alias exists before creating a new one
      # Book.__elasticsearch__.client.indices.delete index: index_name rescue nil
      # Book.__elasticsearch__.client.indices.delete_alias index: "_all", name: alias_name rescue nil

      Book.__elasticsearch__.create_index!(index: index_name, force: true)
      Book.__elasticsearch__.client.indices.put_alias index: index_name, name: alias_name
      Book.create(title: 'Elasticsearch Basics', author: 'John Doe', isbn: '1234567890')
      Book.create(title: 'Advanced Elasticsearch', author: 'Jane Doe', isbn: '0987654321')
      Book.create(title: 'Advanced book', author: 'Jane Doe', isbn: '0987654321')
      Book.__elasticsearch__.refresh_index!
    end

    after do
      Book.__elasticsearch__.client.indices.delete index: index_name rescue nil
      Book.__elasticsearch__.client.indices.delete_alias index: index_name, name: alias_name rescue nil
    end

    context 'when the book exists' do
      it 'returns the book' do
        results = Book.search('Elasticsearch').records
        expect(results.size).to eq(2)
        expect(results.first.title).to eq('Elasticsearch Basics')
      end
    end

    context 'when the book does not exist' do
      it 'returns no results' do
        results = Book.search('Nonexistent').records
        expect(results).to be_empty
      end
    end
  end
end
