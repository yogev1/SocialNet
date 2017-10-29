class SessionsController < ApplicationController
  def create
  	@session = current_user.sessions.new(session_params)
    @session.update(user_id: params[:user_id])
    respond_to do |format|
      if @session.save
        format.html { redirect_to root_path }
      else
        format.html { render :new }
      end
    end
  end

  def destroy
    @session = Session.find_by(user_id: current_user.id)
    @session.destroy
    respond_to do |format|
      format.html { sign_out_and_redirect(current_user)}
      format.json { head :no_content }
    end    
  end

  private
    def post_params
      params.require(:session).permit(:user_id)
    end  
end
