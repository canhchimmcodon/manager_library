class BookConfirmationsController < ApplicationController
  before_action :has_book_pending?, only: %i(index)
  before_action :find_registered_copy, only: %i(update destroy)

  def index; end

  def update
    if @book_confirmation.update_attributes(borrowed: true)
      set_borrowed
      add_book_duration
      add_notification_user(@book_confirmation.card.user_id,
        t(".noti_book_confirmed", title: @book_confirmation.copy.book_title),
        Book.name, @book_confirmation.copy.book_id)
      flash[:success] = t ".updated"
    else
      flash[:warning] = t ".failed"
    end
    redirect_to root_url
  end

  def destroy
    return unless set_available
    @book_confirmation.destroy
    add_notification_user(@book_confirmation.card.user_id,
      t(".noti_book_not_confirmed", title: @book_confirmation.copy.book_title),
      Book.name, @book_confirmation.copy.book_id)
    flash[:success] = t ".not_confirm"
    redirect_back fallback_location: root_path
  end

  private

  def has_book_pending?
    @book_confirmations = RegisteredCopy.page(params[:page]).not_confirmed_yet
    return if @book_confirmations.present?
    flash[:info] = t ".no_book_pending_right_now"
    redirect_to root_url
  end

  def find_registered_copy
    @book_confirmation = RegisteredCopy.find_by id: params[:id]
    return if @book_confirmation
    flash[:warning] = t ".not_exists"
    redirect_to root_url
  end

  def add_book_duration
    @book_confirmation.update_attributes(borrowed_date: Date.today,
      expected_return_date: Settings.EXPIRED_WEEK.weeks.from_now.to_date)
  end

  def set_available
    @copy = Copy.find_by id: @book_confirmation.copy_id
    return if !@copy || @copy.available?
    @copy.set_status :available
  end

  def set_borrowed
    @copy = Copy.find_by id: @book_confirmation.copy_id
    return if !@copy || @copy.borrowed?
    @copy.set_status :borrowed
  end
end
