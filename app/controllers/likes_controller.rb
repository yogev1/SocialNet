class LikesController < ApplicationController
  def create
    post = Post.find_by(id: params[:post_id])
    @like = post.likes.build(post_id: params[:post_id])
    @like.update(user_id: current_user.id)
    respond_to do |format|
      if @like.save
        format.html { redirect_to posts_path }
        format.json { render :show, status: :created, location: post_path(@post) }
      else
        format.html { redirect_to posts_path }
        format.json { render json: @like.errors, status: :unprocessable_entity }
      end
    end     
  end

  def destroy
    @like = Like.find_by(id: params[:id])
    @like.destroy
    respond_to do |format|
      format.html { redirect_to posts_path }
      format.json { head :no_content }
    end     
  end

  private
    def comment_params
      params.require(:like).permit(:post_id, :user_id)
    end  
end