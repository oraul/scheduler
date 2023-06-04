# frozen_string_literal: true

FactoryBot.define do
  factory :schedule do
    title { 'MyString' }
    started_at { Time.zone.now }
    ended_at { 1.hour.from_now }
    room

    after(:build) do |record|
      current_auth_entity = build(:current_auth_entity)

      record.owner_id = current_auth_entity.sub
      record.owner_name = current_auth_entity.name
    end
  end
end
