class BookSearch
  def initialize(fields, operator = "AND")
    @fields = fields
    @operator = operator
  end

  def self.instance(fields, operator = "AND")
    @instance ||= new(fields, operator)
  end

  def search(query)
    query_string = {
      query_string: {
        fields: @fields,
        query: query,
        default_operator: @operator
      }
    }

    BooksIndex.query(query_string).objects
  end
end
