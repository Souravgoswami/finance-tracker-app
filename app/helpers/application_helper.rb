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
		elsif flash[:warning]
			notify(msg)
		elsif flash[:error]
			notify(msg)
		end
	end
end
