class BookSearch
  def self.search(query)
    search_results = BooksIndex.query(query_string: {fields: [:title, :author, :description], query: query}).to_a
    book_ids = search_results.map(&:id)
    Book.where(id: book_ids)
  end
end
