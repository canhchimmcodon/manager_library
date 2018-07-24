class Book < ApplicationRecord
  has_many :comments
  has_many :copies
  has_many :author_books
  has_many :authors, through: :author_books
  belongs_to :category
  belongs_to :publisher

  scope :book_info, ->{select :id, :title, :price}
end
