class ScoresController < ApplicationController
  
  def update 
    @event = Event.find(params[:event_id])
    @score = Score.find(params[:id])
    @score.score = params[:score].to_i
    if @score.save   
      @score.list.set_places
      @score.list.set_ex_aequo_points
      respond_to do |format|
        format.html { redirect_to eliminations_event_path(@event) }
        if @event.status == "eliminations"
          format.js
        else 
          format.js { render :action => "update_finals" }
        end
      end
    end
  end 
  
end