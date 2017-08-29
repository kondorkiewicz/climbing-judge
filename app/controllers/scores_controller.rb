class ScoresController < ApplicationController
  
  def update 
    @event = Event.find(params[:event_id])
    @score = Score.find(params[:id])
    @score.update_attribute(:score, params[:score].to_i)
    if @score.list.scores.size == 1
      @score.update_attributes(place: 1, ex_points: 1)
    else    
      @score.list.set_places
      @score.list.set_ex_aequo_points
    end 
      respond_to do |format|
        if @event.status == "eliminations"
          format.js
        else 
          format.js { render :action => "update_finals" }
        end
      end
  end 
  
end