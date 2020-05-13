class FriendshipsController < ApplicationController
  def create
    new_friend = User.find_by(username: params[:user_name])
    current_user.friendships.create!(friend_id: new_friend.id)
    flash[:success] = 'Added friend'
    redirect_to dashboard_path
  end
end
