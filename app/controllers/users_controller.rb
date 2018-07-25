class UsersController < ApplicationController
  before_action :find_user, only: %i(show)

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      log_in @user
      flash[:info] = t ".message"
      redirect_to @user
    else
      render :new
    end
  end

  def show; end

  private

  def user_params
    params.require(:user).permit :name, :email, :password,
      :password_confirmation
  end

  def find_user
    @user = User.find_by id: params[:id]
    return if @user
    flash[:danger] = t ".notfound"
    redirect_to root_url
  end
end
