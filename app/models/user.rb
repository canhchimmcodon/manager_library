class User < ApplicationRecord
  attr_accessor :remember_token
  enum role: {admin: 0, librarian: 1, user: 2}

  has_one :card
  has_many :comments
  has_many :notifications

  scope :all_user, ->{select :id, :name, :email}

  paginates_per Settings.OBJECT_PER_PAGE

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
    length: {minimum: Settings.MIN_PASSWORD_LENGTH},
    allow_nil: true

  class << self
    def from_omniauth auth
      where(provider: auth.provider,
        uid: auth.uid).first_or_initialize.tap do |user|
        user.provider = auth.provider
        user.uid = auth.uid
        user.email = auth.info.email
        user.first_name = auth.info.first_name
        user.last_name = auth.info.last_name
        user.password = SecureRandom.hex(8) if user.new_record?
        user.name = auth.info.name
        user.save
        user
      end
    end

    def digest string
      cost = if ActiveModel::SecurePassword.min_cost
               BCrypt::Engine::MIN_COST
             else
               BCrypt::Engine.cost
             end
      BCrypt::Password.create string, cost: cost
    end

    def new_token
      SecureRandom.urlsafe_base64
    end
  end

  def current_user? user
    self == user
  end

  def remember
    self.remember_token = User.new_token
    update_attributes remember_digest: User.digest(remember_token)
  end

  def authenticated? remember_token
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password? remember_token
  end

  def forget
    update_attributes remember_digest: nil
  end
end
