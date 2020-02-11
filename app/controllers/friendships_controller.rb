class FriendshipsController < ApplicationController
  def create
    friend = User.where(github_login: params[:github_login]).first
    friendship = current_user.friendships.new(user_id: current_user.id, friend_id: friend.id)
      if friendship.save
        flash[:success] = "Successfully added friend!"
      else
        flash[:error] = "Friend not added successfully."
      end

    redirect_to '/dashboard'
  end
end
