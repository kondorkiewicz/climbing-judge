class ScoresController < ApplicationController
  
  def update 
    @event = Event.find(params[:event_id])
    @score = Score.find(params[:id])
    @score.update(score: params[:score]) 
    @score.list.set_places
    @score.list.set_ex_aequo_points
    respond_to do |format|
        format.js
    end
  end 
  
end