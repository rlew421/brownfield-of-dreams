class FriendshipsController < ApplicationController
  def create
    current_user.friendships.create!(friend_id: params[:friend_id])
  end
end
