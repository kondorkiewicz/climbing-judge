class ScoresController < ApplicationController
  
  def update 
    @event = Event.find(params[:event_id])
    @score = Score.find(params[:id])
    @score.score = params[:score].to_i
    if @score.save   
      @score.list.set_places
      respond_to do |format|
        format.html { redirect_to eliminations_event_path(@event) }
        format.js
      end
    end
  end 
  
end