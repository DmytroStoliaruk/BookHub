class BookSearch
  
  def initialize
    @fields = [:title, :author, :description]
  end
  
  def self.instance
    @instance ||= new
  end

  def search(query)
    query_string = build_query_string(query)

    BooksIndex.query(query_string).objects
  end

  private

  def build_query_string(query)
    {
      query_string: {
        fields: @fields,
        query: query
      }
    }
  end
end
