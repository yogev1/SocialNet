class FriendshipsController < ApplicationController
  
  def new
  end

  def index
  end

  def show
    @friend = User.find(params[:id])
    @posts = current_user.posts
  end
  
  def create
    if current_user.friendships.find_by(email: params[:email])
      something = current_user.friendships.find_by(:email) 
      current_user.friendships.frined_id = something.id 
    end        
  	  @friendship = current_user.friendships.build(friend_id: params[:friend_id])  
      if @friendship.save
        @friend = User.find(params[:friend_id])
        flash[:notice] = "Friend Request Sent To #{@friend.name}"
        redirect_to users_path
      else
        flash[:error] = "Unable to request friendship."
        redirect_to users_path
      end  
  end

  def update
  	@friendship = current_user.all_friendships.select {|f| f.friend_id == params[:id].to_i || f.user_id == params[:id].to_i}[0]
    @friendship.update(accepted: true)
      if @friendship.save
        redirect_to users_path, notice: "Successfully confirmed friend!"
      else
        redirect_to users_path, notice: "Sorry! Could not confirm friend!"
      end
  end

  def destroy
  	@friendship = current_user.friendships.find_by(friend_id: params[:id])
    @friendship.destroy
    flash[:notice] = "Removed friendship."
    redirect_to users_path 
  end

  private

  def user_params
    params.require(:friendship).permit(:user_id, :friend_id, :accepted)
  end
end
