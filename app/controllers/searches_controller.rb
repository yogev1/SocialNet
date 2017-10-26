class SearchesController < ApplicationController
  def index
      
      @results = Post.search(params[:search]).order(:id).to_a + 
        Event.search(params[:search]).order(:name).to_a + 
        User.search(params[:search]).order(:name).to_a
        
  end
end
