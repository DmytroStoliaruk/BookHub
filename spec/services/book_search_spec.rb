require 'rails_helper'

RSpec.describe BookSearch do
  let!(:book1) { create(:book, :search_params1) }
  let!(:book2) { create(:book, :search_params2) }
  
  before(:each) do
    BooksIndex.reset
    BooksIndex.import(force: true) 
  end
  
  describe '.search' do
    it 'returns books matching the query' do
      search_results = BookSearch.search("number")
     
      expect(search_results.size).to eq(2)
      expect(search_results).to match_array([book1, book2])
    end

    it "the books with author exists" do
      search_results = BookSearch.search("Adams")
         
      expect(search_results).to include(book2)
    end
  
    it "the books with description exists" do
      search_results = BookSearch.search("About")
         
      expect(search_results.size).to eq(2)
      expect(search_results).to match_array([book1, book2])
    end
  
    it "the book does not exist" do
      search_results = BookSearch.search("Some title")
         
      expect(search_results).to be_empty
    end
  end
end
