class CommentsController < ApplicationController
  
  def create
    post = Post.find_by(id: params[:post_id])
    @comment = post.comments.build(post_id: params[:post_id])
    @comment.update(user_id: current_user.id, description: params[:comment][:description])
    respond_to do |format|
      if @comment.save
        format.html { redirect_to post_path(post) }
        format.json { render :show, status: :created, location: post_path(@post) }
      else
        format.html { render :new }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end   
  end

  def edit
    @comment = Comment.find_by(id: params[:id])
  end

  def update
    @comment = Comment.find_by(id: params[:id])
    post = Post.find_by(id: @comment.post_id)
    respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_to post_path(post), notice: 'Comment was successfully updated.' }
        format.json { render :show, status: :ok, location: post_path(@post) }
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
      format.html { redirect_to posts_url, notice: 'Comment was successfully destroyed.' }
      format.json { head :no_content }
    end   
  end
  
  private
    def comment_params
      params.require(:comment).permit(:post_id, :user_id, :description)
    end

end
