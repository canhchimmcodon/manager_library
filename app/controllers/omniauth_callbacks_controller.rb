class OmniauthCallbacksController < ApplicationController
  skip_before_action :authenticate_user!, raise: false

  def create
    auth = request.env["omniauth.auth"]
    @user = User.from_omniauth(auth)

    if @user.persisted?
      log_in @user
      flash[:success] = t ".success", s: auth.provider
    else
      flash[:notice] = t(".failed") + @user.errors.full_messages.join
    end
    redirect_to root_path
  end

  def failure
    flash[:notice] = t ".failed"
    redirect_to root_path
  end
end
