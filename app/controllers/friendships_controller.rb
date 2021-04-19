class FriendshipsController < ApplicationController
  def create
    @friendship = Friendship.create!(friend_id: params[:friend_id], user_id: current_user.id, confirmed: false)

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

  private

  # Only allow a list of trusted parameters through.
  def friendships_params
    params.require(:friendships).permit(:user_id, :friend_id, :confirmed)
  end
end
