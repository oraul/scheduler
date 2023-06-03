# frozen_string_literal: true

class Room < ApplicationRecord
  validates :name,
            presence: true,
            uniqueness: { case_sensitive: false }

  validates :opened_at, :closed_at, presence: true

  validates :opened_at, comparison: { less_than: :closed_at }

  validates :closed_at, comparison: { greater_than: :opened_at }
end
