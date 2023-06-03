class RenameEndTimeToClosedAtToRooms < ActiveRecord::Migration[7.0]
  def change
    rename_column :rooms, :end_time, :closed_at
  end
end
