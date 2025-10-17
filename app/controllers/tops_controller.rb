# frozen_string_literal: true

class TopsController < ApplicationController
  def index
    @top_book = Book.all
    filter_by_genre
    @filter = @filter.sort_by { |book| [-book.likes.count, -book.views] }
  end

  private

  def filter_by_genre
    @filter = if params[:genre].present?
                @books.where(genre: params[:genre])
              else
                @books
              end
  end
end
