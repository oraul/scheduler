# frozen_string_literal: true

class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  def record_not_found
    render json: { code: 404, message: I18n.t('error.record_not_found') }, status: :not_found
  end
end
