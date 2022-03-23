class Api::V1::SessionsController < Devise::SessionsController
  skip_before_action :verify_authenticity_token
  respond_to :json

  # KS: When i remove the code from the tutorial below it still works but returns different responses:
  # login success: User model is returned as json
  # login failure: { "error": "Invalid Email or password." } is returned

  private

  def respond_with(_resource, _opts = {})
    render json: { message: 'Logged.' }, status: :ok
  end

  def respond_to_on_destroy
    current_user ? log_out_success : log_out_failure
  end

  def log_out_success
    render json: { message: 'Logged out.' }, status: :ok
  end

  def log_out_failure
    render json: { message: 'Logged out failure.' }, status: :unauthorized
  end
end
