class AddHotelsToTrip < ActiveRecord::Migration[8.0]
  def change
    add_column :trips, :hotel, :string
  end
end
