class User < ApplicationRecord
  has_one :card
  has_many :comments
  has_many :notifications

  before_save{email.downcase!}
  validates :name, presence: true,
    length: {maximum: Settings.MAX_NAME_LENGTH}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true,
    length: {maximum: Settings.MAX_EMAIL_LENGTH},
    format: {with: VALID_EMAIL_REGEX},
    uniqueness: {case_sensitive: false}

  has_secure_password
  validates :password, presence: true,
    length: {minimum: Settings.MIN_PASSWORD_LENGTH}
end
