class ParticipantsController < ApplicationController
  before_action :authenticate_user!
    
  def create
  	event = Event.find_by(id: params[:event_id])
  	@participant = event.participations.build(event_id: params[:event_id])
  	@participant.user_id = current_user.id
    respond_to do |format|
      if @participant.save
        format.html { redirect_to event_path(event) }
        format.json { render :index, status: :created, location: events_path }
      else
        format.html { render :new }
        format.json { render json: @participant.errors, status: :unprocessable_entity }
        redirect_to events_path
      end
    end
  end

  def destroy
  	event = Event.find_by(id: params[:event_id])  	
  	@participant = event.participations.find_by(user_id: params[:id]) 
    @participant.destroy
    respond_to do |format|
      format.html { redirect_to event_path(event) }
      format.json { head :no_content }
    end  	
  end

private
    # Never trust parameters from the scary internet, only allow the white list through.
    def participant_params
      params.require(:participant).permit(:event_id, :user_id)
    end
end
