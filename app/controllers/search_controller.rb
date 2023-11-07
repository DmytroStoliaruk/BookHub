class SearchController < ApplicationController
  def index
    redirect_to books_path(search_params)
  end

  private

  def search_params
    params.require(:search).permit(:query)
  end
end
