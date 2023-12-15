class Reservation < ApplicationRecord
  belongs_to :event_place
  belongs_to :reserved_by, class_name: 'User', foreign_key: 'reserved_by_id'

  validates :start_time, :end_time, :status, presence: true
  validate :start_time_end_time_valid?

  validates :end_time, comparison: { greater_than: :start_time }
  validates :start_time, comparison: { greater_than: Time.now }
  validates :end_time, comparison: { greater_than: Time.now }

  scope :upcomming, -> { where("DATE(end_time) >= ?", Date.today) }

  enum status: {
    accepted: 'accepted',
    rejected: 'rejected',
    cancelled: 'cancelled',
    pending: 'pending'
  }

  def self.ransackable_attributes(auth_object = nil)
    ["event_place_id", "reserved_by_id", "start_time", "end_time", "created_at", "updated_at"]
  end

  private

  def start_time_end_time_valid?
    reservations =  Reservation.accepted.where(event_place: event_place)

    if persisted?
      reservations = reservations.where.not(id: id)
    end

    reservation_start_time_exists =
      reservations.where(
        ":start_time BETWEEN start_time AND end_time", start_time: start_time
      ).any?

    if reservation_start_time_exists
      errors.add(:start_time, "Reservation already exists this start time")
    end

    reservation_end_time_exists =
      reservations.where(
        ":end_time BETWEEN start_time AND end_time", end_time: end_time
      ).any?

    if reservation_end_time_exists
      errors.add(:end_time, "Reservation already exists for this end time")
    end
  end
end
