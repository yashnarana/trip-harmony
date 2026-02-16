# frozen_string_literal: true

# The User model represents an individual user in the application. It manages
# user authentication, associations with trips and expenses, and ensures data
# integrity through validations. Users can create trips and expenses, as well as
# participate in trips and expenses created by others.
class User < ApplicationRecord
  # Include default Devise modules for user authentication
  # Available modules include confirmable, lockable, timeoutable, trackable, and omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Associations

  # Trips that this user has created
  has_many :created_trips, class_name: "Trip", foreign_key: "user_id", dependent: :destroy

  # Trips that the user is participating in, via the join model UserTrip
  has_many :user_trips, dependent: :destroy
  has_many :participating_trips, through: :user_trips, source: :trip

  # Expenses created by the user (money spent by the user)
  has_many :created_expenses, class_name: "Expense", foreign_key: "user_id", dependent: :destroy

  # Expenses the user is participating in (money owed by other users to this user)
  has_many :user_expenses, dependent: :destroy
  has_many :participating_expenses, through: :user_expenses, source: :expense

  # Validations

  # Ensure email is present, unique, and formatted correctly
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }

  # Ensure password is present and has a minimum length of 6 characters
  validates :encrypted_password, presence: true, length: { minimum: 6 }
end
