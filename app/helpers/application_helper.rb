module ApplicationHelper
	def active?(path)
		request.path == path ? 'active' : ''
	end

	def notify(message, button_message = 'Ok')
		javascript_tag "notify('#{message}', '#{button_message}')"
	end

	def flash_notification_manager
		msg = flash[:notice] || flash[:alert] || flash[:error]

		if flash[:notice]
			notify(msg)
		elsif flash[:alert]
			notify(msg)
		elsif flash[:error]
			notify(msg)
		end
	end

	def user_exists?(key, value, case_sensitive = false)
		User.where(
			case_sensitive ? {key => value} : {key => value.downcase}
		).exists?
	end
end
