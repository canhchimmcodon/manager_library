class Card < ApplicationRecord
  has_many :registered_copies
  has_many :copies, through: :registered_copies
  belongs_to :user

  before_create :expired_time

  private

  def expired_time
    self.issued_date = Time.zone.now
    self.expired_date = Settings.EXPIRED_YEAR.years.from_now
  end
end
