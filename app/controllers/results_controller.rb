class ResultsController < ApplicationController
  before_action :set_event
  before_action :authorize_event
  
  def compute_results 
    Result.compute_results(@event, 'M')
    Result.compute_results(@event, 'F')
    @event.status = "finished"; @event.save
    redirect_to event_path(@event)
  end
  
  private 
  
  def set_event 
    @event = Event.find(params[:id])
  end 

  
  
end