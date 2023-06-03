# frozen_string_literal: true

module AuthorizeBearerTokenUseCase
  module_function

  def call(bearer_token, auth_adapter: AuthAdapter, current_auth_entity: CurrentAuthEntity)
    jwt_token = bearer_token&.split(' ')&.last
    decoded_token = auth_adapter.decode(jwt_token)

    current_auth_entity.new(decoded_token)
  end
end
