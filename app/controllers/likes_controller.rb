class LikesController < ApplicationController
  before_action :set_book

  def create
    unless Like.exists?(user_id: current_user.id, book_id: @book.id)
      @like = Like.create(user_id: current_user.id, book_id: @book.id)
    end

    redirect_to book_path(@book)
  end

  def destroy
    if Like.exists?(user_id: current_user.id, book_id: @book.id)
      @like = Like.find_by(user_id: current_user.id, book_id: @book.id)
      @like.destroy
    end

    redirect_to book_path(@book)
  end

  private

  def like_params
    params.require(:like).permit(:user_id, :book_id, :status)
  end

  def set_book
    @book = Book.find(params[:book_id])
  end
end
