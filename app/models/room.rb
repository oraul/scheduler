# frozen_string_literal: true

class Room < ApplicationRecord
  validates :name,
            presence: true,
            uniqueness: { case_sensitive: false }
end
