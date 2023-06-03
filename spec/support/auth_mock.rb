# frozen_string_literal: true

module AuthMock
  def bearer_token_mock(sub: 'dbdc2419-f6cf-49c8-a545-a908a03741ce', name: 'John Doe', exp: 24.hours.from_now.to_i)
    payload = {
      sub:,
      name:,
      exp:,
      iss: 'auth',
      aud: 'scheduler'
    }

    "Bearer #{AuthAdapter.encode(payload)}"
  end
end
