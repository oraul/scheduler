# frozen_string_literal: true

FactoryBot.define do
  factory :current_auth_entity do
    sub { 'dbdc2419-f6cf-49c8-a545-a908a03741ce' }
    name { 'John Doe' }
    exp { 24.hours.from_now.to_i }
    iss { 'auth' }
    aud { 'scheduler' }

    initialize_with { new(attributes) }
  end
end
