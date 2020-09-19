class FriendshipsController < ApplicationController
	def create
	end

	def destroy
		friendship = current_user.friendships.where(friend_id: params[:id])
		friendship.each(&:destroy)
		flash[:notice] = "Stopped following #{current_user.username}"

		redirect_to my_friends_path
	end
end
