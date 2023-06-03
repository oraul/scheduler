# frozen_string_literal: true

class AddStartTimeAndEndTimeToRooms < ActiveRecord::Migration[7.0]
  def change
    change_table :rooms, bulk: true do |t|
      t.time :start_time
      t.time :end_time
    end
  end
end
