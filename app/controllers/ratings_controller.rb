# frozen_string_literal: true

class RatingsController < ApplicationController
  before_action :set_book
  before_action :authenticate_user!
  def create
    @rating = @book.ratings.find_or_initialize_by(user_id: current_user.id)
    @rating.score = params[:score]

    if @rating.save
      redirect_to book_path(@book)
    else
      redirect_to book_path(@book), alert: @rating.errors.full_messages
    end
  end

  private

  def set_book
    @book = Book.find(params[:book_id])
  end
end
