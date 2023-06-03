class RenameStartTimeToOpenedAtToRooms < ActiveRecord::Migration[7.0]
  def change
    rename_column :rooms, :start_time, :opened_at
  end
end
