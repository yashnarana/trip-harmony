class AddNotesToTrip < ActiveRecord::Migration[8.0]
  def change
    add_column :trips, :trip, :string
  end
end
