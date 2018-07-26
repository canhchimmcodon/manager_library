class RegisteredCopiesController < ApplicationController
  before_action :find_book, only: %i(new)

  def new
    @registered_copy = RegisteredCopy.new registered_date: Date.today,
      copy_id: @book.random_copies_available.id,
      card_id: current_user.card_id
  end

  def create
    @registered_copy = RegisteredCopy.new registered_copy_params
    if @registered_copy.save
      flash[:info] = t ".success"
      redirect_to root_url
    else
      render :new
    end
  end

  private

  def registered_copy_params
    params.require(:registered_copy).permit :registered_date, :copy_id, :card_id
  end

  def find_book
    @book = Book.find_by id: params[:book_id]
    return if @book
    flash[:danger] = t ".not_exists"
    redirect_to root_url
  end
end
