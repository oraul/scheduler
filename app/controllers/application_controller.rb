# frozen_string_literal: true

class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  rescue_from JWT::DecodeError, with: :auth_error

  before_action :authorize_bearer_token

  attr_reader :current_auth

  private

  def record_not_found
    render json: { message: I18n.t('error.message.record_not_found'), detail: {} }, status: :not_found
  end

  def auth_error
    render json: { message: I18n.t('error.message.auth_error'), detail: {} }, status: :unauthorized
  end

  def authorize_bearer_token
    @current_auth = AuthorizeBearerTokenUseCase.call(request.headers['Authorization'])
  end
end
