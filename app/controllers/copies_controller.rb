class CopiesController < ApplicationController
  before_action :logged_in_user, :librarian_user,
    only: %i(new create update destroy)
  before_action :find_copy, only: %i(update destroy)
  before_action :copy_support, only: %i(new create)

  def index
    @book = Book.find(params[:book_id])
    @copies = @book.copies.paginate page: params[:page],
      per_page: Settings.BOOK_PER_PAGE
    return if @copies
    flash[:danger] = t ".not_exists"
    redirect_to root_url
  end

  def new
    @copy = Copy.new
  end

  def create
    @copy = Copy.new copy_params
    if @copy.save
      flash[:info] = t ".success"
      redirect_to root_url
    else
      render :new
    end
  end

  def update; end

  def destroy
    @copy.destroy
    flash[:success] = t ".copy_deleted"
    redirect_to books_url
  end

  private

  def copy_params
    params.require(:copy).permit :book_id, :status
  end

  def librarian_user
    redirect_to root_url unless current_user.librarian?
  end

  def find_copy
    @copy = Copy.find_by id: params[:id]
    return if @copy
    flash[:danger] = t ".not_exists"
    redirect_to root_url
  end

  def copy_support
    @copy_support = Supports::CopySupport.new
  end
end
