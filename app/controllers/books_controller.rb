class BooksController < ApplicationController
  def index
    @books = Book.all
    @book = Book.new
  end

  def show
    @book = Book.find(params[:id])
  end

  def create
    @book = Book.new(book_params)

    if @book.save
      redirect_to book_path(@book)
    else
      redirect_to books_path
    end
  end

  private

  def book_params
    params.require(:book).permit(:title, :descriptions, :author, :image)
  end
end
