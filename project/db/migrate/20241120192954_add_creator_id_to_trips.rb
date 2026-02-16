class AddCreatorIdToTrips < ActiveRecord::Migration[8.0]
  def change
    add_column :trips, :creator_id, :integer
  end
end
