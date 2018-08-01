class CommentsController < ApplicationController
  before_action :logged_in_user, only: %i(new create edit update destroy)
  before_action :find_book, only: %i(index create show edit update destroy)
  before_action :find_comment, only: %i(edit update destroy)

  def index
    @comments = @book.comments.confirmed.page(params[:page])
    respond_to do |format|
      format.html
      format.js
    end
  end

  def new
    @comment = Comment.new
  end

  def create
    @comment = current_user.comments.build comment_params
    @comment.book_id = @book.id
    @comment.accepted = true if current_user.librarian? || current_user.admin?

    if @comment.save
      respond_to do |format|
        format.html do
          flash[:success] = t ".success_comment"
          redirect_to @book
        end
        format.js
      end
    end
  end

  def show; end

  def edit; end

  def update
    if @comment.update_attributes(comment_params)
      respond_to do |format|
        format.html do
          flash[:success] = t ".updated"
          redirect_to @book
        end
        format.js
      end
    end
  end

  def destroy
    @comment.destroy
    flash[:success] = t ".destroyed"
    redirect_to @book
  end

  private

  def find_book
    @book = Book.find_by id: params[:book_id]
    return if @book
    flash[:danger] = t ".not_found_book"
    redirect_back fallback_location: root_path
  end

  def find_comment
    @comment = Comment.find_by id: params[:id]
    return if @comment
    flash[:danger] = t ".not_found_comment"
    redirect_back fallback_location: root_path
  end

  def comment_params
    params.require(:comment).permit :content
  end
end
