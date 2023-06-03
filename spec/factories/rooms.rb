# frozen_string_literal: true

FactoryBot.define do
  factory :room do
    sequence(:name) { |i| "Room #{i}" }
    opened_at { '08:00:00' }
    closed_at { '09:00:00' }
  end
end
