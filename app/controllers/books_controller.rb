class BooksController < ApplicationController
  before_action :set_book, only: %i[show update destroy]
  before_action :authenticate_user!, only: %i[create update destroy]

  def index
    @books = Book.page(params[:page]).per(20)
    filter_by_genre
  end

  def show
    BookViewsService.new(current_user, @book, session).track
  end

  def new
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)

    if @book.save
      flash[:notice] = t('book-created')
      redirect_to book_path(@book)
    else
      flash[:alert] = @book.errors.full_messages.to_sentence
      redirect_to new_book_path
    end
  end

  def update
    if @book.update(book_params)
      redirect_to book_path(@book)
    else
      redirect_to book_path(@book), alert: @book.errors.full_messages
    end
  end

  def destroy
    @book.destroy

    respond_to do |format|
      format.turbo_stream { render turbo_stream: turbo_stream.remove(helpers.dom_id(@book)) }
      format.html { redirect_to root_path, status: :see_other }
    end
  end

  private

  def book_params
    params.require(:book).permit(:title, :descriptions, :author, :image, :status, :borrowed_by, :genre)
  end

  def set_book
    @book = Book.find(params[:id])
  end

  def filter_by_genre
    if params[:genre].present?
      @filter = @books.where(genre: params[:genre])
    else
      @filter = @books
    end
  end
end
