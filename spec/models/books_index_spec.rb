require 'rails_helper'

RSpec.describe BooksIndex, type: :chewy do
  let!(:book1) { create(:book, :search_params1) }
  let!(:book2) { create(:book, :search_params2) }
  before(:each) do
    Chewy.strategy(:urgent) 
    BooksIndex.delete
    BooksIndex.create
    BooksIndex.import(force: true) 
  end
  
  describe '.search' do
    it 'returns books matching the query' do
      search_results = BooksIndex.query(query_string: { query: "number", 
                                        fields: [:title, :author, :description] })
      
      expect(search_results.map(&:title)).to include(book1.title, book2.title)
    end

    it "the books with author exists" do
      search_results = BooksIndex.query(query_string: { query: "Adams", 
                                        fields: [:title, :author, :description] })
      
      expect(search_results.map(&:author)).to include(book2.author)
    end
  
    it "the books with description exists" do
      search_results = BooksIndex.query(query_string: { query: "About", 
                                        fields: [:title, :author, :description] })

      expect(search_results.map(&:description)).to include(book1.description, book2.description)
    end
  
    it "the book does not exist" do
      search_results = BooksIndex.query(query_string: { query: "Some title", 
                                        fields: [:title, :author, :description] }).to_a

      expect(search_results).to be_empty
    end
  end
end
