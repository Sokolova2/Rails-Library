# frozen_string_literal: true

class HomeController < ApplicationController
  before_action :set_books

  def index
    @top_book = Book.all.sort_by { |book| [-book.likes.count, -book.views] }

    Impression.where(user_id: current_user.id).destroy_all if user_signed_in?
  end

  private

  def set_books
    @books = Book.search(params[:search]).page(params[:page]).per(20)
  end
end
