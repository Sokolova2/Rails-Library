class HomeController < ApplicationController
  def index
    @books = Book.search(params[:search])
    @top_book = Book.all.sort_by{ |book| -book.likes.count }
  end
end
