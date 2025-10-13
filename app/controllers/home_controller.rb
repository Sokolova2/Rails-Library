class HomeController < ApplicationController
  def index
    @books = Book.search(params[:search])
    @top_book = Book.all.sort_by{ |book| -book.likes.count }

    if user_signed_in?
      Impression.where(user_id: current_user.id).destroy_all
    end
  end
end
