class Copy < ApplicationRecord
  has_many :registered_copies
  has_many :cards, through: :registered_copies
  belongs_to :book
end
