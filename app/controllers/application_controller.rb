class ApplicationController < ActionController::Base
  before_action :set_locale
  protect_from_forgery with: :exception

  def add_notification_user user_id, content, notifiable_type, notifiable_id
    Notification.create!(user_id: user_id, content: content,
      notifiable_type: notifiable_type, notifiable_id: notifiable_id)
  end

  def add_notification_current_user content, notifiable_type, notifiable_id
    add_notification_user(current_user.id,
      content, notifiable_type, notifiable_id)
  end

  def add_notification_librarian_user content, notifiable_type, notifiable_id
    add_notification_user(Settings.LIBRARIAN_ID,
      content, notifiable_type, notifiable_id)
  end

  def add_notification_admin_user content, notifiable_type, notifiable_id
    add_notification_user(Settings.ADMIN_ID,
      content, notifiable_type, notifiable_id)
  end

  def default_url_options
    {locale: I18n.locale}
  end

  private

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end
end
