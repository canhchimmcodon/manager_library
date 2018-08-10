class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    generic_callback("facebook")
  end

  def google_oauth2
    generic_callback("google_oauth2")
  end

  def twitter
    generic_callback("twitter")
  end

  def generic_callback provider
    @user = User.from_omniauth omniauth_params
    if @user.persisted?
      sign_in_and_redirect @user
      set_flash_message(:notice, :success, kind: provider.capitalize) if is_navigational_format?
    else
      session["devise.#{provider}_data"] = omniauth_params
      redirect_to new_user_registration_url
    end
  end

  def failure
    redirect_to root_path
  end

  private
  def omniauth_params
    request.env["omniauth.auth"]
  end
end
