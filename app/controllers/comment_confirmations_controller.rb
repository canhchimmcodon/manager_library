class CommentConfirmationsController < ApplicationController
  before_action :has_comment_pending?, only: %i(index)
  before_action :find_comment, only: %i(update destroy)

  def index; end

  def update
    if @comment_confirmation.update_attributes(accepted: true)
      flash[:success] = t ".updated"
    else
      flash[:danger] = t ".failed"
    end
    redirect_back fallback_location: root_path
  end

  def destroy
    @comment_confirmation.destroy
    redirect_back fallback_location: root_path
  end

  private

  def has_comment_pending?
    @comment_confirmations = Comment.page(params[:page]).not_confirmed_yet
    return if @comment_confirmations.present?
    flash[:danger] = t ".no_comment_pending_right_now"
    redirect_to root_url
  end

  def find_comment
    @comment_confirmation = Comment.find_by id: params[:id]
    return if @comment_confirmation
    flash[:danger] = t ".not_exists"
    redirect_to root_url
  end
end
