class ApplicationController < ActionController::Base
  before_action :set_locale
  protect_from_forgery with: :exception
  include SessionsHelper

  def librarian_user
    User.find_by id: Settings.LIBRARIAN_ID
  end

  def admin_user
    User.find_by id: Settings.ADMIN_ID
  end

  def add_notification_current_user content
    current_user.notifications.create!(content: content)
  end

  def add_notification_admin_user content
    admin_user.notifications.create!(content: content)
  end

  def default_url_options
    {locale: I18n.locale}
  end

  private

  def logged_in_user
    return if logged_in?
    store_location
    flash[:danger] = t "please_login"
    redirect_to login_url
  end

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end
end
