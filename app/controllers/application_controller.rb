class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?
  rescue_from Pundit::NotAuthorizedError, :with => :not_authorize

  include Pundit

  private

    def not_authorize
      flash[:alert] = "You cannot do this action"
      redirect_to "/"
    end

  protected

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:full_name, :username])
      devise_parameter_sanitizer.permit(:account_update, keys: [:full_name, :username])
    end
end
