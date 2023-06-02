# frozen_string_literal: true

class CreateSchedules < ActiveRecord::Migration[7.0]
  def change
    create_table :schedules do |t|
      t.string :title
      t.datetime :start_time
      t.datetime :end_time
      t.belongs_to :room, null: false, foreign_key: true

      t.timestamps
    end
  end
end
