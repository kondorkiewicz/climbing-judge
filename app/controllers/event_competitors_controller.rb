class EventCompetitorsController < ApplicationController
  before_action :set_event
  before_action :authorize_event
  
  def competitors 
    if @event.status != "competitors"
      redirect_to send("#{@event.status}_event_path"),
            warning: 'You need to delete scores from a round you are currently in to go back!'
    else
      @competitors_from_db = Competitor.search(params[:search])
    end 
  end 
  
  def add_competitor
    @competitor = Competitor.find(params[:competitor_id])
    @event.competitors << @competitor unless @event.competitors.include?(@competitor)
    respond_to do |format|
      format.html { redirect_to competitors_event_path(event) }
      format.js {}
    end 
  end
  
  def delete_competitor
    @competitor = Competitor.find(params[:competitor_id])
    @event.competitors.delete(@competitor)
    respond_to do |format|
      format.html { redirect_to competitors_event_path(event) }
      format.js {}
    end 
  end
  
  private
  
  def set_event
    @event = Event.find(params[:id])
  end
  
  
end 