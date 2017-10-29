class ApplicationController < ActionController::Base
  require 'uri'
  protect_from_forgery with: :exception
  before_action :update_sanitized_params, if: :devise_controller?
  before_action :get_time
  before_action :get_url_search
  before_action :create_user_session  

	def get_time
		@time_now = Time.zone.now
  end

	def update_sanitized_params
	  devise_parameter_sanitizer.permit(:sign_up) {|u| u.permit(:name, :image, :password, :email)}
	  devise_parameter_sanitizer.permit(:sign_in) {|u| u.permit(:name, :password, :email)}
	end

  def get_url_search  
    @url = URI::parse(request.original_url)
    @url = @url.path.split('/')
    i = 0
    while i < @url.length-3 && @url[i] != "searches"
      @url = @url.pop(1)    
      i += 1
    end
    @url = @url.join
  end

  def create_user_session
    if user_signed_in? 
      if !Session.find_by(user_id: current_user.id)
        Session.create(user_id: current_user.id)
      end
    end  
  end    
end
