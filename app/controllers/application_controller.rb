# frozen_string_literal: true

class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  def record_not_found
    render json: { message: I18n.t('error.message.record_not_found') }, status: :not_found
  end
end
