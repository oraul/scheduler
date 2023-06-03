# frozen_string_literal: true

FactoryBot.define do
  factory :schedule do
    title { 'MyString' }
    started_at { Time.zone.now }
    ended_at { 1.hour.from_now }
    room
  end
end
