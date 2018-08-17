class Copy < ApplicationRecord
  enum status: {available: 0, registered: 1, borrowed: 2}

  has_one :registered_copy
  has_many :cards, through: :registered_copies
  belongs_to :book

  scope :available_copies, ->{where status: :available}

  delegate :title, to: :book, prefix: true, allow_nil: true

  paginates_per Settings.BOOK_PER_PAGE

  def set_status new_status
    update_attributes status: new_status
  end

  def registering_user
    return if available?
    registered_copy.card.user
  end
end
