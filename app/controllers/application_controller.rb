class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_in) << :name
    devise_parameter_sanitizer.for(:sign_up) << :name
    # [review] 細かいですが、まとめて↓みたいに書くこともできます！
    # devise_parameter_sanitizer.for(:sign_up) << %i(name email)
    devise_parameter_sanitizer.for(:sign_up) << :email
    devise_parameter_sanitizer.for(:account_update) << :name
  end
end
