require 'rails_helper'

RSpec.describe BooksIndex, type: :chewy do
  let!(:book1) { create(:book, :search_params1) }
  let!(:book2) { create(:book, :search_params1) }
  before(:all) do
    Chewy.strategy(:urgent) 
    BooksIndex.create
    BooksIndex.import(force: true) 
  end
  
  describe '.search' do
    it 'returns books matching the query' do
      search_results = BooksIndex.query(query_string: { query: "number", 
                                        fields: [:title, :author, :description] })
      
      expect(search_results.map(&:title)).to include(book1.title, book2.title)
    end
  end
end
