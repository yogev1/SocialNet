class FriendsController < ApplicationController
  before_action :authenticate_user!
  
  def create      
    @friend = current_user.friendships.build(friend_id: params[:friend_id])
    #@friend.update(user_id: current_user.id)  
    if @friend.save
      flash[:notice] = "Friend Request Sent"
      redirect_to users_path
    else
      flash[:error] = "Unable to request friendship."
      redirect_to users_path
    end  
  end

  def update
    user = User.find_by(id: params[:id])
    @friend = user.friendships.find_by(user_id: params[:id])
    @friend.update(accepted: true)
    if @friend.save
      redirect_to users_path, notice: "You're Now Friends"
    else
      redirect_to users_path, notice: "Sorry, Could not confirm friendship!"
    end 
  end

  def destroy
    user = User.find_by(id: params[:id])
  	@friend = user.friendships.find_by(user_id: params[:id])
    @friend.destroy
    flash[:notice] = "Removed Friendship"
    redirect_to users_path 
  end

  private

  def user_params
    params.require(:friend).permit(:friend_id, :accepted)
  end
end
