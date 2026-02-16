class AddTripRefToExpense < ActiveRecord::Migration[8.0]
  def change
    add_reference :expenses, :trip, null: false, foreign_key: true
  end
end
