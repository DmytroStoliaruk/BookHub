# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Books", type: :request do

  let(:book) { create(:book) }
  let(:valid_params) { attributes_for(:book) }
  let(:invalid_params) { 
    attributes_for(:book).merge(title: "")
  }
  let(:new_params) {
    { title: "New Title", author: "New Author", isbn: "1111-2222-000", description: "New Description" }
  }

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
      get edit_book_url(book.id)
      expect(response).to be_successful   
    end
  end

  describe "GET #books(:id) - show book" do
    it "returns http success" do
      get book_path(book.id)
      expect(response).to be_successful
    end
  end

  describe "POST #create" do
    it "creates a new book" do
      expect {
        post books_url, params: { book: valid_params }
      }.to change(Book, :count).by(1)
    end

    it "creates a new book with invalid attributes)" do
        post books_url, params: { book: invalid_params }
        expect(response).to be_unprocessable
    end
  end

  describe "PATCH #update" do
    it "update book" do
      patch book_path(book), params: { book: new_params }
      book.reload

      new_params.each_pair do |key, value|
        expect(book[key]).to eq(value)
      end

      expect(response).to redirect_to(book_path(book))
    end

    it "update book with invalid parameters" do
      patch book_path(book), params: { book: invalid_params }
      expect(response).to be_unprocessable
    end
  end

  describe "DELETE #books(:id)" do
    it "deletes the book and redirects to the books index" do
      book = Book.create valid_params

      expect {
        delete book_path(book)
      }.to change(Book, :count).by(-1)

      expect(response).to redirect_to(books_path)
    end
  end
end
