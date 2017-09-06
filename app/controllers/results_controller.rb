class ResultsController < ApplicationController
  before_action :set_event, :authorize_event, :check_finished_status
  before_action { check_status('finals') }
  
  def compute_results 
    if correct_scores?(@event.round_lists('finals'))
      Result.compute_results(@event, 'men')
      Result.compute_results(@event, 'women')
      @event.status = "finished"; @event.save
      redirect_to event_path(@event)  
    else 
      redirect_to finals_event_path, 
        warning: "Every score has to be greater than zero!"
    end 
  end  
  
end