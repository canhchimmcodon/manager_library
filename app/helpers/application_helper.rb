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

  def confirm_title
    base_title = t("_header.confirm")
    count = RegisteredCopy.not_confirmed_yet.count +
      Comment.not_confirmed_yet.count
    if count.positive?
      base_title + " (" + count.to_s + ")"
    else
      base_title
    end
  end

  def book_confirm_title
    base_title = t("_header.book_confirm")
    count = RegisteredCopy.not_confirmed_yet.count
    if count.positive?
      base_title + " (" + count.to_s + ")"
    else
      base_title
    end
  end

  def comment_confirm_title
    base_title = t("_header.comment_confirm")
    count = Comment.not_confirmed_yet.count
    if count.positive?
      base_title + " (" + count.to_s + ")"
    else
      base_title
    end
  end
end
