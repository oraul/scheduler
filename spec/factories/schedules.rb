# frozen_string_literal: true

FactoryBot.define do
  factory :schedule do
    title { 'MyString' }
    start_time { Time.zone.now }
    end_time { 1.hour.from_now }
    room
  end
end
