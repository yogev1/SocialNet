class EventCommentsController < ApplicationController
  def create
    event = Event.find_by(id: params[:event_id])
    @event_comment = event.event_comments.build(event_id: params[:event_id])
    @event_comment.update(user_id: current_user.id, description: params[:event_comment][:description])
    respond_to do |format|
      if @event_comment.save
        format.html { redirect_to event_path(event) }
        format.json { render :show, status: :created, location: event_path(event)}
      else
        format.html { render :new }
        format.json { render json: @event_comment.errors, status: :unprocessable_entity }
      end
    end   
  end

  def edit
    @event_comment = EventComment.find_by(id: params[:id])
    @event = Event.find_by(id: params[:event_id])
  end

  def update
    event = Event.find_by(id: @event_comment.event_id)
    @event_comment = event.event_comments.find_by(id: params[:id])
    respond_to do |format|
      if @event_comment.update(event_comment_params)
        format.html { redirect_to event_path(event), notice: 'Comment was successfully updated.' }
        format.json { render :show, status: :ok, location: event_path(@event) }
      else
        format.html { render :edit }
        format.json { render json: @event_comment.errors, status: :unprocessable_entity }
      end
    end   
  end

  def destroy
    @event = Event.find_by(id: params[:event_id])
    @event_comment = EventComment.find_by(id: params[:id])
    @event_comment.destroy
    respond_to do |format|
      format.html { redirect_to @event, notice: 'Comment was successfully destroyed.' }
      format.json { head :no_content }
    end   
  end
  
  private
    def event_comment_params
      params.require(:event_comment).permit(:event_id, :user_id, :description)
    end	
end
