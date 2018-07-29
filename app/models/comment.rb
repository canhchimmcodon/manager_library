class Comment < ApplicationRecord
  belongs_to :book
  belongs_to :user

  scope :all_comments, ->{order(created_at: :asc)}
  
  validates :content, presence: true
  paginates_per Settings.OBJECT_PER_PAGE
end
