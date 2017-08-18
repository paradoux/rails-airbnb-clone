class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    # For additional fields in app/views/devise/registrations/new.html.erb
    # CGN : permettre l'ajout de prenom + nom à la creation du compte
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :address, :bio])

    # For additional in app/views/devise/registrations/edit.html.erb
    # CGN : permettre la modif de nom + prenom + address + bio
    devise_parameter_sanitizer.permit(:account_update, keys: [:username, :address, :bio])
  end

end
