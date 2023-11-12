class BooksController < ApplicationController
  def index
    @books = collection
  end

  def new
    @book = Book.new
  end

  def show
    @book = resourse
  end

  def edit
    @book = resourse
  end

  def create
    @book = Book.new(book_params)

    if @book.save
      redirect_to books_path, notice: "Book was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    @book = resourse

    if @book.update(book_params)
      redirect_to @book, notice: "Book was successfully updated.", status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    resourse.destroy

    redirect_to books_path, alert: "Book was successfully destroyed.", status: :see_other
  end

  def search
    @books = Book.search(params[:search][:query]).records
    if @books.any?
      flash.now[:notice] = "Books found: #{@books.total}"
    else
      flash.now[:alert] = "No books found."
      @books = collection
    end

    render :index
  end

  private

  def book_params
    params.require(:book).permit(:title, :author, :isbn, :description, :cover, :content, :search)
  end

  def collection
    Book.ordered
  end

  def resourse
    collection.find(params[:id])
  end
end
