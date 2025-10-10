class UpdateBookStatusController < ApplicationController
  before_action :set_book

  def update
    if @book.status == 'Open'
      @book.update(status: 'Closed', user_id: current_user.id)
      History.create(user_id: current_user.id, book_id: @book.id, status: 'took')
    else
      @book.update(status: 'Open', user_id: nil)
      history = History.find_by(user_id: current_user.id, book_id: @book.id)
      history.update(status: 'return')
    end

    redirect_to fallback_location: root_path
  end

  private

  def set_book
    @book = Book.find(params[:book_id])
  end
end
