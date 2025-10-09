class RatingsController < ApplicationController
  before_action :set_book

  def create
    unless Rating.exists?(user_id: current_user.id, book_id: @book.id)
      @rating = Rating.create(user_id: current_user.id, book_id: @book.id, score: params[:score])
    end

    redirect_to book_path(@book)
  end

  def destroy
    if Rating.exists?(user_id: current_user.id, book_id: @book.id)
      @rating = Rating.find_by(user_id: current_user.id, book_id: @book.id)
      @rating.destroy
    end

    redirect_to book_path(@book)
  end

  private

  def set_book
    @book = Book.find(params[:book_id])
  end
end
