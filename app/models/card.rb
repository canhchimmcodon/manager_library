class Card < ApplicationRecord
  has_many :registered_copies
  has_many :copies, through: :registered_copies
  belongs_to :user
end
