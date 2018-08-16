module ApplicationHelper
  def full_title page_title = ""
    base_title = t :base_title
    if page_title.empty?
      base_title
    else
      page_title + " | " + base_title
    end
  end

  def notification_title
    base_title = t("_header.notifications")
    if current_user.unread_notifications_count.positive?
      base_title + " (" + current_user.unread_notifications_count.to_s + ")"
    else
      base_title
    end
  end
end
