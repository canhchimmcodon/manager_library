class Book < ApplicationRecord
  has_many :comments
  has_many :copies
  has_many :author_books
  has_many :authors, through: :author_books
  belongs_to :category
  belongs_to :publisher

  scope :book_info, ->{select :id, :title, :price}
  scope :book_by_name, ->(search){where("title LIKE ?", "%#{search}%")}
  delegate :name, to: :publisher, prefix: true, allow_nil: true
  delegate :name, to: :category, prefix: true, allow_nil: true

  validates :title, presence: true
  validates :price, presence: true
  validates :isbn, presence: true, uniqueness: true

  paginates_per Settings.BOOK_PER_PAGE

  def copies_available
    copies.available_copies
  end

  def copies_available_count
    copies.available_copies.count
  end

  def random_copies_available
    copies.available_copies.sample
  end
end
