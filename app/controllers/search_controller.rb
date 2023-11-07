class SearchController < ApplicationController
  def index
    @search_result = Book.search(search_params)

    if @search_result.any?
      message = "Found #{ @search_result.count} books"
    else
      message = "No results found"
    end
    puts message
    redirect_to books_path(books: @search_result), notice: message
  end

  private

  def search_params
    params.require(:search).permit(:query)
  end
end
