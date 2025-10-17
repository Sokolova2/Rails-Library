# frozen_string_literal: true

class HomeController < ApplicationController
  before_action :set_books
  def index
    @top_book = Book.all.sort_by { |book| [-book.likes.count, -book.views] }
    return unless user_signed_in?

    Impression.where(user_id: current_user.id).destroy_all
  end

  private

  def set_books
    @books = Book.search(params[:search]).page(params[:page]).per(20)
  end
end
