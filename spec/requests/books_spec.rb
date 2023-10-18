# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Books", type: :request do


  let(:valid_attributes) {
    { title: "New title", author: "Author", isbn: "1111-2222-333", description: "Description" }
  }
  
  let(:invalid_attributes) {
    { title: "", author: "Author", isbn: "1111-2222-333", description: "Description" }
  }

  let(:new_attributes) {
    { title: "New Title", author: "New Author", isbn: "1111-2222-000", description: "New Description" }
  }

  let(:valid_book) { create(:book) }

  describe "GET #books - show list of books" do
    it "returns http success" do
      get books_url
      expect(response).to be_successful
    end
  end 

  describe "GET #books/new - create new book" do
    it "returns http success" do
      get new_book_url
      expect(response).to be_successful
    end
  end

  describe "GET #books(:id)/edit - edit book" do
    it "returns http success" do
      get edit_book_url(valid_book.id)
      expect(response).to be_successful   
    end
  end

  describe "GET #books(:id) - show book" do
    it "returns http success" do
      get book_path(valid_book.id)
      expect(response).to be_successful
    end
  end

  describe "POST #create" do
    it "creates a new book" do
      expect {
        post books_url, params: { book: valid_attributes }
      }.to change(Book, :count).by(1)
    end

    it "creates a new book with invalid attributes)" do
        post books_url, params: { book: invalid_attributes }
        expect(response).to be_unprocessable
    end
  end

  describe "PUT #update" do
    it "update book" do
      patch book_path(valid_book), params: { book: new_attributes }
      valid_book.reload

      expect(valid_book.title).to eq("New Title")
      expect(valid_book.author).to eq("New Author")
      expect(valid_book.isbn).to eq("1111-2222-000")
      expect(valid_book.description).to eq("New Description")
    end

    it "update book with invalid parameters" do
      patch book_path(valid_book), params: { book: invalid_attributes }
      expect(response).to be_unprocessable
    end
  end

  describe "DELETE #books(:id)" do
    it "deletes the book and redirects to the books index" do

      book = Book.create! valid_attributes

      expect {
        delete book_path(book)
      }.to change(Book, :count).by(-1)

      expect(response).to redirect_to(books_path)
    end
  end

end
