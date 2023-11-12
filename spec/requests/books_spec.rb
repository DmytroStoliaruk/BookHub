require "rails_helper"

RSpec.describe BooksController, type: :request do

  around do |example|
    Chewy.strategy(:urgent) do
      example.run
    end
  end

  let!(:book) { create(:book) }
  let(:valid_params) { attributes_for(:book) }
  let(:invalid_params) { attributes_for(:book).merge(title: "") }
  let(:new_params) { attributes_for(:book).merge(title: "New Title") }

  describe "GET #books - index of books" do
    it "renders the title of the book" do
      get books_path

      expect(response).to be_successful
      expect(response.body).to include(CGI.escapeHTML(book.title))
    end
  end

  describe "GET #books(:id) - show one book" do
    it "returns http success" do
      get book_path(book)

      expect(response).to be_successful
      expect(response.body).to include(CGI.escapeHTML(book.title))
    end
  end

  describe "GET #books/new - create new book form" do
    it "returns http success" do
      get new_book_path

      expect(response).to be_successful
    end
  end

  describe "GET #books(:id)/edit - edit book" do
    it "returns http success" do
      get edit_book_path(book)

      expect(response).to be_successful
      expect(response.body).to include(CGI.escapeHTML(book.title))
    end
  end

  describe "POST #create" do
    it "creates a new book" do
      expect do
        post books_path, params: { book: valid_params }
      end.to change(Book, :count).by(1)

      expect(response).to be_redirect
      expect(flash[:notice]).to eq("Book was successfully created.")
    end

    it "create a new book with invalid attributes)" do
      expect do
        post books_url, params: { book: invalid_params }
      end.to_not change(Book, :count)

      expect(response).to be_unprocessable
      expect(response.body).to include(CGI.escapeHTML("can't be blank"))
    end
  end

  describe "PATCH #update" do
    it "update book" do
      expect do
        patch book_path(book), params: { book: new_params }
        book.reload
      end.to change { book.title }.from(book.title).to("New Title")

      expect(response).to redirect_to(book_path(book))
      expect(flash[:notice]).to eq("Book was successfully updated.")
    end

    it "update book with invalid parameters" do
      patch book_path(book), params: { book: invalid_params }

      expect(response).to be_unprocessable
      expect(response.body).to include(CGI.escapeHTML("can't be blank"))
    end
  end

  describe "DELETE #books(:id)" do
    it "deletes the book and redirects to the books index" do
      expect do
        delete book_path(book)
      end.to change(Book, :count).by(-1)

      expect(response).to redirect_to(books_path)
      expect(flash[:alert]).to eq("Book was successfully destroyed.")
    end
  end

  describe 'GET #search' do
    let!(:book1) { create(:book, :search_params1) }
    let!(:book2) { create(:book, :search_params2) }
    let(:collection) { [book1, book2] }

    before do
      allow(Book).to receive(:search).and_return(double("Search test", records: collection))
    end

    # context "when search query is provided" do
    #   it "assigns @books with the search results" do
    #     get search_books_path, params: { search: { query: "number" } }

    #     expect(assigns(:books)).to match_array(collection)
    #     expect(response).to render_template(:index)
    #   end
    # end

    # context "when search query is empty" do
    #   it "assigns @books with the default collection" do
    #     allow(Book).to receive(:search).and_return(double("Search test", records: []))
    #     get search_books_path, params: { search: { query: "" } }

    #     expect(assigns(:books)).to match_array(Book.all)
    #     expect(response).to render_template(:index)
    #   end
    # end
  end
end
