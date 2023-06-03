# frozen_string_literal: true

class Schedule < ApplicationRecord
  belongs_to :room

  validates :title, :started_at, :ended_at, presence: true

  scope :time_committed?, lambda { |started_at, ended_at|
    where("
      tstzrange(
        started_at,
        ended_at,
        '[]'
      ) && tstzrange(?, ?, '[]')
    ", started_at, ended_at)
  }
end
