class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :get_time

	def get_time
		@time_now = Time.zone.now
  end


end
