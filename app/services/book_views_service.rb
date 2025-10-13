class BookViewsService
  def initialize(user, book, session)
    @user = user
    @book = book
    @session = session
  end

  def track
    if @user
      impressions = Impression.where(book_id: @book.id, user_id: @user.id)

      unless impressions.exists?
        Impression.create(book_id: @book.id, user_id: @user.id)
        @book.inc(views: 1)
      end
    end
  end
end