class ApplicationController < ActionController::Base
  # include DeviseTokenAuth::Concerns::SetUserByToken
  protect_from_forgery unless: -> { request.format.json? }

  before_action :configure_permitted_parameters, if: :devise_controller?

  private

  # permit params on update registration.
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:account_update, keys: [:name])
  end
end
