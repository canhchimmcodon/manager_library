class NotificationsController < ApplicationController
  before_action :find_notification, only: %i(destroy)
  after_action :read_notifications, only: %i(index)

  def index
    @notifications = current_user.notifications
                                 .page(params[:page])
                                 .all_notifications
  end

  def create; end

  def destroy
    @notification.destroy
    flash[:success] = t ".notification_deleted"
    redirect_back fallback_location: root_path
  end

  private

  def find_notification
    @notification = Notification.find_by id: params[:id]
    return if @notification
    flash[:warning] = t ".not_exists"
    redirect_to root_url
  end

  def read_notifications
    @notifications.unread.update_all(read: true)
  end
end
