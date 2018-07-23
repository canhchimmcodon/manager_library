class User < ApplicationRecord
  has_one :card
  has_many :comments
  has_many :notifications
end
