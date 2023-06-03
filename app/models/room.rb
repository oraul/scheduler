# frozen_string_literal: true

class Room < ApplicationRecord
  validates :name,
            presence: true,
            uniqueness: { case_sensitive: false }

  validates :start_time, :end_time, presence: true

  validates :start_time, comparison: { less_than: :end_time }

  validates :end_time, comparison: { greater_than: :start_time }
end
