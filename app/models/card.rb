class Card < ApplicationRecord
  has_many :registered_copies
  has_many :copies, through: :registered_copies
  belongs_to :user

  before_create :expired_time

  delegate :name, to: :user, prefix: true, allow_nil: true

  def registered_copies_count
    registered_copies.count
  end

  def expected_return_dates
    registered_copies.map(&:expected_return_date)
  end

  def has_book_not_return?
    expected_return_dates.compact.any?{|date| date < Date.today}
  end

  def can_borrow
    registered_copies_count < Settings.MAX_BORROWED_BOOK
  end

  private

  def expired_time
    self.issued_date = Time.zone.now
    self.expired_date = Settings.EXPIRED_YEAR.years.from_now
  end
end
