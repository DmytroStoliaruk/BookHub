require "rails_helper"

RSpec.describe "Books", type: :request do
  let!(:book) { create(:book) }
  let(:valid_params) { attributes_for(:book) }
  let(:invalid_params) { attributes_for(:book).merge(title: "") }
  let(:new_params) { attributes_for(:book).merge(title: "New Title") }

  describe "GET #books - show list of books" do
    it "renders the title of the book" do
      get books_path

      expect(response).to be_successful
      expect(response).to be_successful
      expect(response.body).to include(CGI.escapeHTML(CGI.escapeHTML(book.title)))
    end
  end

  describe "GET #books(:id) - show one book" do
    it "returns http success" do
      get book_path(book)

      expect(response.body).to include(book.title)
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
      expect(response.body).to include(book.title)
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
      expect(response.body).to include("can&#39;t be blank")
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
end
