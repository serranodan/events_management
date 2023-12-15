class ApplicationController < ActionController::Base
  protect_from_forgery

  def after_sign_in_path_for(resource)
    current_user.professor? ? admin_dashboard_path : admin_reservations_path
  end

  def access_denied(exception)
    redirect_path = current_user.professor? ? admin_dashboard_path : admin_reservations_path
    redirect_to redirect_path, alert: exception.message
  end
end
