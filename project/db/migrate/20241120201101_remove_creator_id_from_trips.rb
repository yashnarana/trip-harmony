class RemoveCreatorIdFromTrips < ActiveRecord::Migration[8.0]
  def change
    remove_column :trips, :creator_id, :integer
  end
end
