# frozen_string_literal: true

class RenameStartTimeToStartedAtToSchedules < ActiveRecord::Migration[7.0]
  def change
    rename_column :schedules, :start_time, :started_at
  end
end
