# frozen_string_literal: true

# The UserTrip model serves as a join table for the many-to-many relationship
# between users and trips. Each record in this model represents a single user's
# participation in a specific trip. It allows the application to manage and
# query which users are associated with which trips and vice versa.
class UserTrip < ApplicationRecord
  # Associations

  # Links this record to a specific user who is participating in the trip
  belongs_to :user

  # Links this record to a specific trip in which the user is a participant
  belongs_to :trip
end
