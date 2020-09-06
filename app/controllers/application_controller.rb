class ApplicationController < ActionController::Base
	before_action :authenticate_user!, except: [:email, :username]

	helper_method :logged_in?
	before_action :configure_permitted_parameters, if: :devise_controller?

	def logged_in?
		!!current_user
	end

	def configure_permitted_parameters
		devise_parameter_sanitizer.permit(:account_update, keys: %i[
			username first_name last_name
		])

		devise_parameter_sanitizer.permit(:sign_up, keys: %i[
			username first_name last_name
		])
	end
end
