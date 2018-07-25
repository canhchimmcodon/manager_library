class Book < ApplicationRecord
  has_many :comments
  has_many :copies
  has_many :author_books
  has_many :authors, through: :author_books
  belongs_to :category
  belongs_to :publisher

  scope :book_info, ->{select :id, :title, :price}
  delegate :name, to: :publisher, prefix: true, allow_nil: true
  delegate :name, to: :category, prefix: true, allow_nil: true

  validates :isbn, presence: true, uniqueness: true
end
