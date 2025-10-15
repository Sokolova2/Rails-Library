class UpdateBookStatusService
  def initialize(book, user)
    @book = book
    @user = user
  end

  def update_book_status
    book = Favorite.where(book_id: @book.id)

    favorite = book.pluck(:user_id)

    user = User.in(id: favorite)

    if @book.status == 'Open'
      @book.update(status: 'Closed', user_id: @user.id)
      History.create(user_id: @user.id, book_id: @book.id, status: 'took')
      user.each do |u|
        Message.create(user_id: u.id, content: "Book \"#{@book.title}\" status updated. The book from your favorite is now closed for use")
      end
    else
      @book.update(status: 'Open', user_id: nil)
      history = History.where(book_id: @book.id).last
      history.update(status: 'return')
      user.each do |u|
        Message.create(user_id: u.id, content: "Book \"#{@book.title}\" status updated. The book from your favorite is now open for use again")
      end
    end
  end
end