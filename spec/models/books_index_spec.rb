require 'rails_helper'

RSpec.describe BooksIndex, type: :chewy do
  before(:all) do
    Chewy.strategy(:urgent) 
    BooksIndex.delete
    create(:book, title: 'UniqueTitleOne')
    create(:book, title: 'UniqueTitleTwo')
    BooksIndex.create
    BooksIndex.import(force: true)  # Обязательно после создания книг
    sleep 1  # Дать время на индексацию
  end
  
  after(:all) do
    BooksIndex.delete
  end
  
  describe '.search' do
    
    
    it 'returns books matching the query' do
      search_results = BooksIndex.query(query_string: {fields: [:title, :author, :description], query: "UniqueTitle"}).to_a

      puts "Search Results: #{search_results.inspect}"
      expect(search_results.map(&:title)).to include('UniqueTitleOne', 'UniqueTitleTwo')

    end
  end
end
