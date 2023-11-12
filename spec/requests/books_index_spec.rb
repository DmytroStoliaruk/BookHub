require "rails_helper"

RSpec.describe BooksIndex, type: :request do
  describe 'GET #search' do
    let!(:book1) { create(:book, :search_params1) }
    let!(:book2) { create(:book, :search_params2) }

    describe "when a search query is provided" do
      before do
        allow(BooksIndex).to receive(:search).and_return([book1, book2])
      end

      it "returns the search results" do
        get search_books_path, params: { search: { query: "number" } }

        expect(assigns(:books)).to match_array([book1, book2])
        expect(response).to render_template(:index)
      end
    end

    describe "when the search query is empty" do
      before do
        allow(BooksIndex).to receive(:search).and_return(Book.all.to_a)
      end

      it "returns all books as the default collection" do
        get search_books_path, params: { search: { query: "" } }

        expect(assigns(:books)).to match_array(Book.all)
        expect(response).to render_template(:index)
      end
    end
  end
end
