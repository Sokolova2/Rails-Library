# frozen_string_literal: true

class UpdateBookStatusService
  def initialize(book, user)
    @book = book
    @user = user
  end

  def update_book_status
    if @book.status == 'Open'
      book_open
      create_history
      message_close_book
    elsif @book.status == 'Closed'
      book_close
      update_history
      message_open_book
    end
  end

  private

  def users_favorite_books
    book_favorites = Favorite.where(book_id: @book.id)

    users_favorites = book_favorites.pluck(:user_id)

    @users = User.in(id: users_favorites)
  end

  def book_open
    users_favorite_books

    @book.update(status: 'Closed', user_id: @user.id)
  end

  def book_close
    users_favorite_books

    @book.update(status: 'Open', user_id: nil)
  end

  def create_history
    History.create(user_id: @user.id, book_id: @book.id, status: 'took')
  end

  def update_history
    history = History.where(book_id: @book.id).last
    history.update(status: 'return')
  end

  def message_close_book
    @users.each do |u|
      Message.create(
        user_id: u.id,
        content: "Book \"#{@book.title}\" status updated. The book from your favorite is now closed for use"
      )
    end
  end

  def message_open_book
    @users.each do |u|
      Message.create(
        user_id: u.id,
        content: "Book \"#{@book.title}\" status updated. The book from your favorite is now open for use again"
      )
    end
  end
end
