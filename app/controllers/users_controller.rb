class UsersController < ApplicationController
	def my_portfolio
		@tracked_stocks = current_user.stocks
	end

	def my_friends
		@friends = current_user.friends
	end

	def search
		if params[:friend].present?
			@friends = User.search(params[:friend])
			@friends = current_user.except_current_user(@friends)

			if @friends
				# render 'users/_friend_result'
				respond_to do |f|
					f.js { render partial: 'users/friend_result' }
				end
			else
				flash.now[:alert] = 'Could not find user in database'

				respond_to do |f|
					f.js { render partial: 'users/friend_result' }
				end
			end
		else
			flash.now[:alert] = 'Please enter an username or email to search'
			respond_to do |f|
				f.js { render partial: 'users/friend_result' }
			end
			# render json: params[:friend].to_json
		end
	end
end
