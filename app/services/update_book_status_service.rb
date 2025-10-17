# frozen_string_literal: true

class UpdateBookStatusService
  def initialize(book, user)
    @book = book
    @user = user
  end

  def update_book_status
    # TODO: change name
    # TODO Move user favorite logic to separate method
    book_favorites = Favorite.where(book_id: @book.id)

    users = book_favorites.pluck(:user_id)

    @users_favorite = User.in(id: users)

    if @book.status == 'Open'
      book_open
    elsif @book.status == 'Closed'
      book_close
    end
  end

  def book_open
    @book.update(status: 'Closed', user_id: @user.id)
    # TODO: move history to another method
    History.create(user_id: @user.id, book_id: @book.id, status: 'took')
    @users_favorite.each do |u|
      Message.create(
        user_id: u.id,
        content: "Book \"#{@book.title}\" status updated. The book from your favorite is now closed for use"
      )
    end
  end

  def book_close
    @book.update(status: 'Open', user_id: nil)
    history = History.where(book_id: @book.id).last
    history.update(status: 'return')
    @users_favorite.each do |u|
      Message.create(
        user_id: u.id,
        content: "Book \"#{@book.title}\" status updated. The book from your favorite is now open for use again"
      )
    end
  end
end
