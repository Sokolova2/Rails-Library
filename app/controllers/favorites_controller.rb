# frozen_string_literal: true

class FavoritesController < ApplicationController
  before_action :set_book, only: %i[create destroy]

  def index; end

  def show
    favorite = Favorite.where(user: current_user.id).pluck(:book_id)
    @favorite_books = Book.in(id: favorite)
  end

  def create
    return if Favorite.exists?(user_id: current_user.id, book_id: @book.id)

    @favorite = Favorite.create(user_id: current_user.id, book_id: @book.id)

    redirect_back(fallback_location: root_path)
  end

  def destroy
    return unless Favorite.exists?(user_id: current_user.id, book_id: @book.id)

    @favorite = Favorite.find_by(user_id: current_user.id, book_id: @book.id)
    @favorite.destroy

    redirect_back(fallback_location: root_path)
  end

  private

  def set_book
    @book = Book.find(params[:book_id])
  end
end
