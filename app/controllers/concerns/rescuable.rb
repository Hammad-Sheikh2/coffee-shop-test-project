# typed: false
# frozen_string_literal: false

module Rescuable
  extend ActiveSupport::Concern

  included do
    rescue_from StandardError,                              with: :render_internal_error
    rescue_from ActiveRecord::RecordNotFound,               with: :render_not_found
    rescue_from ActiveRecord::RecordInvalid,                with: :render_record_invalid
    rescue_from ActionController::ParameterMissing,         with: :render_parameter_missing
    rescue_from ActionController::InvalidAuthenticityToken, with: :dont_rescue_authenticity_token
    rescue_from ActionController::UnknownFormat,            with: :render_unknown_format
  end

  def render_unknown_format(_exception)
    render json: { error: 'Unknown Format' }, status: :not_acceptable
  end

  def render_not_found(_exception)
    render json: { error: '404 not found' }, status: :not_found
  end

  def render_record_invalid(_exception)
    render json: { error: 'record invalid' }, status: :bad_request
  end

  def render_parameter_missing(_exception)
    render json: { error: 'missing params' }, status: :unprocessable_entity
  end

  def dont_rescue_authenticity_token(exception)
    raise exception
  end

  def render_internal_error(_exception)
    render json: { error: 'Internal Server Error' }, status: :internal_server_error
  end
end
