class FinalsController < ApplicationController
  before_action :set_event
  before_action :authorize
  before_action :authorize_event
  before_action :check_finished_status
  before_action only: [:delete_eliminations_lists] { check_status('finals') }

  def finals 
    if @event.finals_lists('f').empty?
      redirect_to send("#{@event.status}_event_path"), warning: 'There are no lists for Finals!'   
    else 
      @m = @event.list('f', 'M')
      @f = @event.list('f', 'F')
    end 
  end 
  
  def create_finals_lists 
    comps_number = params[:comps_number].to_i
    path = @event.status
    begin 
      @event.create_finals_list('M', comps_number)
      @event.create_finals_list('F', comps_number)
      comps_number == 8 ? @event.status = "finals" : @event.status = "semi_finals"
      @event.save 
      redirect_to send("#{@event.status}_event_path"), info: "Lists have been created."
    rescue => e 
      redirect_to send("#{path}_event_path"), danger: "#{e.message}"
    end 
  end 
  
  def delete_finals_lists
    @event.lists.where(round: 'f').destroy_all
    if @event.lists.where(round: 'sf').empty? 
      @event.status = "eliminations_results"; @event.save
      redirect_to eliminations_results_event_path(@event)
    else 
      @event.status = "semi_finals"; @event.save
      redirect_to semi_finals_event_path(@event)
    end  
  end 

end