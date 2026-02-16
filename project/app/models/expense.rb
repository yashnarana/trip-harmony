# frozen_string_literal: true

# The Expense model represents an individual expense within a trip.
# It includes information about the creator, associated participants,
# and the trip it belongs to. The model validates key attributes like
# description, amount, date, and categories, and it establishes relationships
# with users and trips to manage the expense lifecycle effectively.
class Expense < ApplicationRecord
  # 'creator' is the user who created the expense
  belongs_to :creator, class_name: "User", foreign_key: "user_id"
  # Participants related to the expense via the join model UserExpense
  has_many :user_expenses, dependent: :destroy
  has_many :participants, through: :user_expenses, source: :user

  # The trip to which the expense belongs
  belongs_to :trip, foreign_key: "trip_id"

  # Validations
  validates :description, presence: true, length: { maximum: 255 }
  validates :t_amount, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :expense_date, presence: true
  validates :categories, presence: true, length: { maximum: 100 }
  # validates :category, presence: true
end
