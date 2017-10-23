class CommentsController < ApplicationController
  
  def create
    post = Post.find_by(id: params[:post_id])
    @comment = post.comments.build(post_id: params[:post_id])
    @comment.update(user_id: current_user.id, description: params[:comment][:description])
    respond_to do |format|
      if @comment.save
        format.html { redirect_to posts_path }
        format.json { render :show, status: :created, location: posts_path }
      else
        format.html { render :new }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end   
  end

  def edit
    @post = Post.find_by(id: params[:post_id])
    @comment = Comment.find_by(id: params[:id])
  end

  def update
    @comment = Comment.find_by(id: params[:id])
    respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_to posts_path, notice: 'Comment was successfully updated.' }
        format.json { render :show, status: :ok, location: posts_path }
      else
        format.html { render :edit }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end   
  end

  def destroy
    @comment = current_user.comments.find_by(id: params[:id])
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to posts_path, notice: 'Comment was successfully destroyed.' }
      format.json { head :no_content }
    end   
  end
  
  private
    def comment_params
      params.require(:comment).permit(:post_id, :user_id, :description)
    end

end
