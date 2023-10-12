require 'rails_helper'

RSpec.describe "Books", type: :request do

  let(:book) { books(:one) } 

  let(:update_param) do
    {
      book: {
        title: "New Title",
        author: "New Author",
        isbn: "111-1111-11111",
        description: "Test description"
      }
    }
  end
  
  describe "GET /books - show list of books" do
    it "returns http success" do
      get "/books"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /books/new - create new book" do
    it "returns http success" do
      get "/books/new"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /books/:id/edit - edit book" do
    it "returns http success" do
      get edit_book_path(book.id)
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /books/:id - show book" do
    it "returns http success" do
      get book_path(book.id)
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST /create" do
    it "creates a new book" do
      expect {
        post "/books", params: update_param
      }.to change(Book, :count).by(1)
    end
  end

  describe "PUT /update" do
    it "updates the requested book" do
      put book_path(book.id), params: update_param
      book.reload
      expect(book.title).to eq("New Title")
      expect(book.author).to eq("New Author")
    end
  end

  describe "DELETE /books/:id" do
    it "deletes the book and redirects to the books index" do
      expect {
        delete book_path(book)
      }.to change(Book, :count).by(-1)
      expect(response).to redirect_to(books_path)
    end
  end

end
