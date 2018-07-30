class Copy < ApplicationRecord
  enum status: {available: 0, registered: 1, borrowed: 2}

  has_many :registered_copies
  has_many :cards, through: :registered_copies
  belongs_to :book

  scope :available_copies, ->{where status: :available}

  paginates_per Settings.BOOK_PER_PAGE

  def set_status new_status
    update_attributes status: new_status
  end
end
