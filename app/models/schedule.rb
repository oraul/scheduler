# frozen_string_literal: true

class Schedule < ApplicationRecord
  belongs_to :room

  validates :title, :start_time, :end_time, presence: true
end
