class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  skip_before_action :authenticate_user!, only: :home
  before_action :load_repos
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

<<<<<<< HEAD
  def load_repos
    return [] unless current_user
    @client = Octokit::Client.new(access_token: current_user.access_token)
    @repos = @client.repos
  end
=======

>>>>>>> master
end
