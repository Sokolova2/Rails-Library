# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :set_book
  def create
    Comment.create(user_id: current_user.id, book_id: @book.id, content: params[:content])

    redirect_to book_path(@book)
  end

  private

  def set_book
    @book = Book.find(params[:book_id])
  end
end
