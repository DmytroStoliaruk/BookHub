require "rails_helper"

RSpec.describe BookSearch, type: :request do
  describe 'GET #search' do
    let!(:book) { create(:book) }
    let!(:book1) { create(:book, title: "Book number one", author: "John Smith", description: "About nature") }
    let!(:book2) { create(:book, title: "Book number two", author: "Sara Adams", description: "About future") }


    before(:each) do
      BooksIndex.reset
    end

    describe "when a search query is provided" do
      it "returns the search results" do
        get search_books_path, params: { search: { query: "number" } }

        expect(response.body).to include(CGI.escapeHTML(book1.title))
        expect(response.body).to include(CGI.escapeHTML(book2.title))
        expect(response.body).not_to include(CGI.escapeHTML(book.title))
      end
    end

    describe "when the search query is empty" do
      it "check that collection is empty" do
        get search_books_path, params: { search: { query: "" } }

        expect(response.body).to include(CGI.escapeHTML("Books found: 0"))
      end
    end
  end
end
