class RegisteredCopy < ApplicationRecord
  belongs_to :card
  belongs_to :copy
end
