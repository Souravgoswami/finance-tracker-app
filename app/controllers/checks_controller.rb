class ChecksController < ApplicationController
	def email
		@email = params['email']

		respond_to do |f|
			f.js
		end
	end

	def username
		@username = params['username']

		respond_to do |f|
			f.js
		end
	end
end
