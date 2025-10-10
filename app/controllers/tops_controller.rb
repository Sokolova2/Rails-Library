class TopsController < ApplicationController
  def index
    @top_book = Book.all.sort_by{ |book| -book.likes.count }
  end
end
