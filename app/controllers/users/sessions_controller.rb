# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  respond_to :json

  private

  def respond_to_on_destroy
    current_user ? log_out_failure : log_out_success
  end

  def log_out_success
    render json: { message: 'Logged out.' }, status: :ok
  end

  def log_out_failure
    render json: { error: 'Logged out failure.' }, status: :unauthorized
  end
end
