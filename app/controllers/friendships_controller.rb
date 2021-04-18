class FriendshipsController < ApplicationController
  def create
    @friendship = Friendship.create!(user_id: current_user.id, friend_id: params[:friend_id], confirmed: false)
    redirect_to users_path if @friendship.save
  end

  def update
    @friendship = Friendship.find(params[:id])
    @friendship.confirm_friend
    redirect_to users_path
  end

  def destroy
    Friendship.find(params[:id]).destroy
    redirect_to users_path
  end
end
