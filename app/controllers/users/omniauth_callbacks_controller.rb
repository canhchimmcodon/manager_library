class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def all
    @user = User.from_omniauth omniauth_params
    if @user.persisted?
      sign_in_and_redirect @user
    else
      session["devise.#{all}_data"] = omniauth_params
      redirect_to new_user_registration_url
    end
  end
  
  alias_method :facebook, :all
  alias_method :google_oauth2, :all
  alias_method :twitter, :all
 
  def failure
    redirect_to root_path
  end

  private
  def omniauth_params
    request.env["omniauth.auth"]
  end
end
