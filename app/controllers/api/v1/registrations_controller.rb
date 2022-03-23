class Api::V1::RegistrationsController < Devise::RegistrationsController
  skip_before_action :verify_authenticity_token
  respond_to :json

  # KS: When i remove the code from the tutorial below it still works but returns different responses:
  # success: User model is returned as json
  # failure: ActiveRecord model errors are returned as json

  private

  def respond_with(resource, _opts = {})
    resource.persisted? ? register_success : register_failed
  end

  def register_success
    render json: { message: 'Signed up.' }
  end

  def register_failed
    render json: { message: 'Signed up failed.' }
  end
end
