class BooksController < ApplicationController
  before_action :logged_in_user, :librarian_user,
    only: %i(new create edit update destroy)
  before_action :find_book, only: %i(show edit update destroy)

  def index
    @books = Book.book_info.paginate page: params[:page],
      per_page: Settings.BOOK_PER_PAGE
  end

  def new
    @book_support = Supports::BookSupport.new
  end

  def create
    @book = Book.new book_params
    if @book.save
      flash[:info] = t ".success"
      redirect_to root_url
    else
      render :new
    end
  end

  def show; end

  def edit; end

  def update; end

  def destroy; end

  private

  def book_params
    params.require(:book).permit :title,
      :price, :isbn, :publisher_id, :category_id
  end

  def librarian_user
    redirect_to root_url unless current_user.librarian?
  end

  def find_book
    @book = Book.find_by id: params[:id]
    return if @book
    flash[:danger] = t ".not_exists"
    redirect_to root_url
  end
end
