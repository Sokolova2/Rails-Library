# frozen_string_literal: true

class TopsController < ApplicationController
  before_action :filter_by_genre

  def index
    @filter = @filter.sort_by { |book| [-book.likes.count, -book.views] }
  end

  private

  def filter_by_genre
    @top_books = Book.all

    @filter = if params[:genre].present?
                @top_books.where(genre: params[:genre])
              else
                @top_books
              end
  end
end
