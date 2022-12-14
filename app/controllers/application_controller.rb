class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  skip_before_action :authenticate_user!, only: :home
  # Devise setup
  before_action :configure_permitted_parameters, if: :devise_controller?

  # rescue github auth errors
  rescue_from StandardError do |exception|
    e = exception
    puts e.message
    raise e
  end

  def configure_permitted_parameters
    # For additional fields in app/views/devise/registrations/new.html.erb
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name])
  end

  def home
  end
end
