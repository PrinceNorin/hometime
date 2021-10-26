class Reservation < ApplicationRecord
  # More status according to business requirement
  STATUSES = { accepted: 0, cancelled: 1 }
  enum status: STATUSES

  belongs_to :guest

  validates :start_date, presence: true, date: true
  validates :end_date, presence: true, date: true
  validates :code, presence: true, uniqueness: true

  # Store moeny as integer of the lowest denomination
  validates :payout_amount,
    presence: true,
    numericality: true
  validates :security_amount,
    presence: true,
    numericality: true
  validates :total_amount,
    presence: true,
    numericality: true

  validates_numericality_of :number_of_nights, greater_than: 0
  validates_numericality_of :number_of_guests, greater_than: 0
  validates_numericality_of :number_of_adults, :number_of_children, :number_of_infants

  validate :valid_reservation_date

  private

  def valid_reservation_date
    return if start_date.nil? || end_date.nil?

    if start_date >= end_date
      self.errors.add(:end_date, :less_than_date, field: :start_date)
    end
  end
end
