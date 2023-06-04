# frozen_string_literal: true

namespace :dev do
  desc 'Generate DEVELOPMENT jwt token'
  task generate_jwt_token: :environment do
    raise 'Test it only on development environment' unless Rails.env.development?
    require_relative '../../spec/support/auth_mock'
    include AuthMock

    puts bearer_token_mock
  end
end
