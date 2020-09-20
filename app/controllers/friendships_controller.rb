class FriendshipsController < ApplicationController
	def create
		@friend = User.find(params[:friend])
		current_user.friendships.build(friend_id: @friend.id)
		# @stock = Stock.new_lookup(@ticker_name)
		# @tracked_stocks = current_user.stocks


		if current_user.save
			flash[:notice] = "You are now following #{@friend.username}"
		else
			flash[:notice] = "There was something wrong with the tracking request"
		end

		respond_to do |f|
			f.js { render 'create.js.erb' }
		end
	end

	def destroy
		friendship = current_user.friendships.where(friend_id: params[:id])
		friendship.each(&:destroy)
		flash[:notice] = "Stopped following #{current_user.username}"

		redirect_to my_friends_path
	end
end
