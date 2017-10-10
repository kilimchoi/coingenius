class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :store_current_location, unless: :devise_controller?
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username])
    devise_parameter_sanitizer.permit(:account_update, keys: [:username])
  end

  private

  def after_sign_in_path_for(_resource)
    if session["user_return_to"] == "/landing_page" && !current_user.nil?
      portfolio_path
    else
      session["user_return_to"] || root_path
    end
  end

  def store_current_location
    store_location_for(:user, request.url)
  end
end
