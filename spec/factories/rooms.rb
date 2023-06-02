# frozen_string_literal: true

FactoryBot.define do
  factory :room do
    sequence(:name) { |i| "Room #{i}" }
  end
end
