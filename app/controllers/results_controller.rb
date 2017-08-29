class ResultsController < ApplicationController
  before_action :set_event
  before_action :authorize_event
  before_action :check_finished_status
  before_action { check_status('finals') }
  
  def compute_results 
    begin 
      Result.compute_results(@event, 'M')
      Result.compute_results(@event, 'F')
      @event.status = "finished"; @event.save
      redirect_to event_path(@event)  
    rescue => e 
      redirect_to send("#{@event.status}_event_path"), danger: "#{e.message}"
    end 
  end  
  
end