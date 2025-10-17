# frozen_string_literal: true

class BookViewsService
  def initialize(user, book, session)
    @user = user
    @book = book
    @session = session
  end

  def track
    return unless @user

    impressions = Impression.where(book_id: @book.id, user_id: @user.id)

    return if impressions.present?

    Impression.create(book_id: @book.id, user_id: @user.id)
    @book.inc(views: 1)
  end
end
