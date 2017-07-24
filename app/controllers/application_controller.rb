class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :update_sanitized_params, if: :devise_controller?

	def update_sanitized_params
	  devise_parameter_sanitizer.permit(:sign_up) {|u| u.permit(:name, :image, :password, :email)}
	  devise_parameter_sanitizer.permit(:sign_in) {|u| u.permit(:name, :password, :email)}
	end
end
