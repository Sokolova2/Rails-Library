class BooksController < ApplicationController
  before_action :set_book, only: %i[show update]
  def index
    @books = Book.all
    @book = Book.new
  end

  def show; end

  def create
    @book = Book.new(book_params)

    if @book.save
      redirect_to book_path(@book)
    else
      redirect_to books_path
    end
  end

  def update

  end

  private

  def book_params
    params.require(:book).permit(:title, :descriptions, :author, :image, :status, :borrowed_by)
  end

  def set_book
    @book = Book.find(params[:id])
  end
end
