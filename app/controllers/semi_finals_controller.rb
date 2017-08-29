class SemiFinalsController < ApplicationController
  before_action :set_event
  before_action :authorize
  before_action :authorize_event
  before_action :check_finished_status
  before_action only: [:delete_eliminations_lists] { check_status('semi_finals') }
  
  def semi_finals
    if @event.finals_lists('sf').empty?
      redirect_to send("#{@event.status}_event_path"), warning: 'There are no lists for Semi-Finals!' 
    elsif @event.status != "semi_finals"
      redirect_to send("#{@event.status}_event_path"),
              warning: 'You need to delete scores from a round you are currently in to go back!'
    else 
      @m = @event.list('sf', 'M')
      @f = @event.list('sf', 'F')
      render template: 'finals/finals'
    end 
  end 
  
  def delete_semi_finals_lists
    @event.lists.where(round: 'sf').destroy_all
    @event.status = "eliminations_results"; @event.save
    redirect_to eliminations_results_event_path(@event)
  end
  
end 