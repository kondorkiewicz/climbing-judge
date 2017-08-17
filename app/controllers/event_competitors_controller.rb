class EventCompetitorsController < ApplicationController
  before_action :set_event
  
  def competitors 
    @competitors_from_db = Competitor.search(params[:search]) 
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