class RegisteredCopy < ApplicationRecord
  belongs_to :card
  belongs_to :copy

  scope :not_confirmed_yet, ->{where borrowed: false}
end
