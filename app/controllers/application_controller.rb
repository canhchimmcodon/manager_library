class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :set_locale
  protect_from_forgery with: :exception

  def add_notification_user id, content
    user = User.find_by id: id
    user.notifications.create!(content: content)
  end

  def add_notification_current_user content
    current_user.notifications.create!(content: content)
  end

  def add_notification_librarian_user content
    add_notification_user(Settings.LIBRARIAN_ID, content)
  end

  def add_notification_admin_user content
    add_notification_user(Settings.ADMIN_ID, content)
  end

  def default_url_options
    {locale: I18n.locale}
  end

  private

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end
end
