# frozen_string_literal: true

class RenameEndTimeToEndedAtToSchedules < ActiveRecord::Migration[7.0]
  def change
    rename_column :schedules, :end_time, :ended_at
  end
end
