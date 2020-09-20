class UsersController < ApplicationController
	def my_portfolio
		@tracked_stocks = current_user.stocks
		@user = current_user
	end

	def my_friends
		@friends = current_user.friends
	end

	def search
		if params[:friend].present?
			@friends = current_user.except_current_user(User.search(params[:friend]))

			if @friends
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
			flash.now[:alert] = 'Please enter a username or email to search'
			respond_to do |f|
				f.js { render partial: 'users/friend_result' }
			end
		end
	end

	def show
		@user = User.find(params[:id])
		@tracked_stocks = @user.stocks
	end
end
