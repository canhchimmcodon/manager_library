class Notification < ApplicationRecord
  belongs_to :user

  scope :all_notifications, ->{order(created_at: :desc)}
  paginates_per Settings.NOTIFICATION_PER_PAGE

  def new_notification content
    update_attributes content: content
  end
end
