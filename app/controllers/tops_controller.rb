class TopsController < ApplicationController
  def index
    @top_book = Book.all
    filter_by_genre
    @filter = @filter.sort_by { |book| [-book.likes.count, -book.views] }
  end

  private

  def filter_by_genre
    if params[:genre].present?
      @filter = @top_book.where(genre: params[:genre])
    else
      @filter = @top_book
    end
  end
end
