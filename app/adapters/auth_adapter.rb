# frozen_string_literal: true

class AuthAdapter
  class << self
    SECRET_TOKEN = ENV.fetch('AUTH_SECRET_TOKEN')

    ALGORITHM = 'HS256'

    def encode(payload, jwt: JWT)
      jwt.encode(payload, SECRET_TOKEN)
    end

    def decode(token, jwt: JWT)
      jwt.decode(token, SECRET_TOKEN, true, algorithm: ALGORITHM)[0]
    end
  end
end
