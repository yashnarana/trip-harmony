# frozen_string_literal: true

# The UserExpense model represents the many-to-many relationship between users and expenses.
# It associates users who are participants in specific expenses. Each record in this model
# connects one user to one expense, allowing the application to track which users are involved
# in which expenses.
class UserExpense < ApplicationRecord
  # Associations

  # The user associated with the expense
  belongs_to :user

  # The expense associated with the user
  belongs_to :expense
end
