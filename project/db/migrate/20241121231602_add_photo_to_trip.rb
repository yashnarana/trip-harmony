class AddPhotoToTrip < ActiveRecord::Migration[8.0]
  def change
    add_column :trips, :photo, :binary
  end
end
