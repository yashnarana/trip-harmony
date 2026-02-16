# frozen_string_literal: true

# The Trip model represents a journey or vacation created by a user.
# It tracks associated participants, expenses, and additional attributes
# such as dates, hotel details, and an optional photo. The model enforces
# data integrity through validations and manages relationships with users
# and expenses for efficient trip management.
class Trip < ApplicationRecord
  # Associations

  # The user who created the trip
  belongs_to :creator, class_name: "User", foreign_key: "user_id"
  # Participants related to the trip via the join model UserTrip
  has_many :user_trips, dependent: :destroy
  has_many :participants, through: :user_trips, source: :user
  # Expenses related to the trip
  has_many :expenses, dependent: :destroy

  # Attachments
  # Optional photo associated with the trip
  has_one_attached :photo

  # Validations:

  # Name of the trip must be present and have a maximum length of 100 characters
  validates :name, presence: true, length: { maximum: 100 }
  # Start date of the trip must be present
  validates :start_date, presence: true
  # End date of the trip must be present and logically follow the start date
  validates :end_date, presence: true
  validate :end_date_after_start_date
  # Optional hotel name with a maximum length of 100 characters
  validates :hotel, length: { maximum: 100 }, allow_blank: true
  # Optional trip description with a maximum length of 100 characters
  validates :trip, length: { maximum: 100 }, allow_blank: true

  private

  # Custom validation to ensure the end date is after the start date
  def end_date_after_start_date
    # Exit early if the validation conditions are not met
    return unless start_date.present? && end_date.present? && end_date < start_date

    errors.add(:end_date, "must be after the start date")
  end
end
