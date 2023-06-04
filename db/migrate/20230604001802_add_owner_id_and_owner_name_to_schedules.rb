# frozen_string_literal: true

class AddOwnerIdAndOwnerNameToSchedules < ActiveRecord::Migration[7.0]
  def change
    change_table :schedules, bulk: true do |t|
      t.uuid :owner_id, index: true
      t.string :owner_name
    end
  end
end
