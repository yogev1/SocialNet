class CommentsController < ApplicationController
  
  def new
    @comment = Comment.new(post_id: params[:post_id])
    @post = Post.find_by(id: params[:post_id])
  end

  def index
  end

  def show
  end

  def create
    @comment = Post.find_by(id: params[:post_id]).comments.new(comment_params)
    respond_to do |format|
      if @comment.save
        format.html { redirect_to posts_path, notice: 'Comment was successfully Added' }
        format.json { render :index, status: :created, location: @comment }
      else
        format.html { redirect_to posts_path, notice: 'Comment can not be Added' }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end    
  end

  def update
    @comment = Comment.find_by(id: params[:post_id])
    respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_to posts_path, notice: 'The Comment was successfully updated' }
        format.json { render :show, status: :ok, location: @comment }
      else
        format.html { render :edit }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end    
  end

  def destroy
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to comments_url, notice: 'Comment was successfully destroyed.' }
      format.json { head :no_content }
    end    
  end

  private

    def comment_params
      params.require(:comment).permit(:post_id, :description)
    end
end
