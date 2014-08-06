class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :get_categories
  before_filter :get_current_user
  helper_method :current_user
  

	
	def get_current_user
		current_user
	end

  private
	def get_categories
		@categories = Category.all.order(:name)
	end

	def authorize
  	redirect_to login_path, alert: "Not authorized" if current_user.nil?
	end
	
	def current_user
		@current_user ||= User.find(session[:user_id]) if session[:user_id]
	end

end