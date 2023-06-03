# frozen_string_literal: true

class Schedule < ApplicationRecord
  belongs_to :room

  validates :title, :start_time, :end_time, presence: true

  scope :time_committed?, lambda { |start_time, end_time|
    where("
      tstzrange(
        start_time,
        end_time,
        '[]'
      ) && tstzrange(?, ?, '[]')
    ", start_time, end_time)
  }
end
