class LikesController < ApplicationController

  def create
  	post = Post.find_by(id: params[:post_id])
  	@like = post.likes.build(post_id: params[:post_id])
    respond_to do |format|
      if @like.save
        format.html { redirect_to posts_path, notice: 'someone liked your post' }
        format.json { render :index, status: :created, location: @like }
      else
        format.html { redirect_to posts_path, notice: 'could not like!' }
        format.json { render json: @like.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
  	@like.destroy
    respond_to do |format|
      format.html { redirect_to likes_url, notice: 'like was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def like_params
      params.require(:like).permit(:post_id)
    end
end
