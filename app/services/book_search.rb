class BookSearch
  def self.search(query)
    BooksIndex.query(query_string: {fields: [:title, :author, :description], query: query}).objects
  end
end
