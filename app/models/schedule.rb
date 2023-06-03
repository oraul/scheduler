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

  validate :room_commited?

  private

  def room_commited?
    return unless self.class.where(room_id:).time_committed?(started_at, ended_at).where.not(id:).exists?

    errors.add(:room_id, :committed)
  end
end
