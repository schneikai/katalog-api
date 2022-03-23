class ApplicationController < ActionController::Base
  def authenticate_user!
    redirect_to new_user_session_path unless current_user
  end

  def authenticate_admin_user!
    redirect_to new_user_session_path and return unless current_user

    head :forbidden unless current_user.is_admin?
  end
end
