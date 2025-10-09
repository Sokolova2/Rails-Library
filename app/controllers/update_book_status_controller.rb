class UpdateBookStatusController < ApplicationController
  before_action :set_book

  def update
    if @book.status == 'Open'
      @book.update(status: 'Closed', user_id: current_user.id)
    else
      @book.update(status: 'Open', user_id: nil)
    end

    redirect_to book_path(@book)
  end

  private

  def set_book
    @book = Book.find(params[:book_id])
  end
end
