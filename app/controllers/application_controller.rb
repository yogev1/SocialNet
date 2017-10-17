class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_filter :authenticate_user!

  before_action :update_sanitized_params, if: :devise_controller?
  before_action :get_time

	def get_time
		@time_now = Time.zone.now
  end

	def update_sanitized_params
	  devise_parameter_sanitizer.permit(:sign_up) {|u| u.permit(:name, :image, :password, :email)}
	  devise_parameter_sanitizer.permit(:sign_in) {|u| u.permit(:name, :password, :email)}
	end
end
