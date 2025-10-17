# frozen_string_literal: true

class TopsController < ApplicationController
  def index

    @top_books = Book.all
    filter_by_genre
    @filter = @filter.sort_by { |book| [-book.likes.count, -book.views] }
  end

  private

  def filter_by_genre
    @filter = if params[:genre].present?
                @top_books.where(genre: params[:genre])
              else
                @top_books
              end
  end
end
