# frozen_string_literal: true

FactoryBot.define do
  factory :room do
    sequence(:name) { |i| "Room #{i}" }
    start_time { '08:00:00' }
    end_time { '09:00:00' }
  end
end
