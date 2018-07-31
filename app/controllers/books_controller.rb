class BooksController < ApplicationController
  before_action :logged_in_user, :librarian_user,
    only: %i(new create edit update destroy)
  before_action :find_book, only: %i(show edit update destroy)
  before_action :book_support, only: %i(new edit create)

  def index
    @books = Book.page(params[:page]).book_info
  end

  def new
    @book = Book.new
  end

  def create
    @book = Book.new book_params
    if @book.save
      flash[:info] = t ".success"
      add_notification_current_user t(".notification_book_created",
        title: @book.title)
      redirect_to root_url
    else
      render :new
    end
  end

  def show; end

  def edit; end

  def update
    if @book.update_attributes(book_params)
      flash[:success] = t ".book_updated"
      redirect_to @book
    else
      render :edit
    end
  end

  def destroy
    @book.destroy
    flash[:success] = t ".book_deleted"
    redirect_to books_url
  end

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

  def book_support
    @book_support = Supports::BookSupport.new
  end
end
