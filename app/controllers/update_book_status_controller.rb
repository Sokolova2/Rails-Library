class UpdateBookStatusController < ApplicationController
  before_action :set_book

  def update
    UpdateBookStatusService.new(@book, current_user).update_book_status

    redirect_back fallback_location: root_path
  end

  private

  def set_book
    @book = Book.find(params[:book_id])
  end
end
