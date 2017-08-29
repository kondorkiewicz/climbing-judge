class EliminationsController < ApplicationController
  before_action :set_event
  before_action :authorize
  before_action :authorize_event
  before_action :check_finished_status
  before_action only: [:delete_eliminations_lists] { check_status('eliminations') }
  
  def eliminations  
    if @event.eliminations_lists.empty?
      redirect_to competitors_event_path(@event), warning: 'There are no eliminations lists!' 
    elsif @event.status != "eliminations"
      redirect_to send("#{@event.status}_event_path"),
              warning: 'You need to delete scores from a round you are currently in to go back!'
    else 
      @m1 = @event.list('el_1', 'M')
      @f1 = @event.list('el_1', 'F')
      @m2 = @event.list('el_2', 'M')
      @f2 = @event.list('el_2', 'F')
    end 
  end 
  
  def create_eliminations_lists 
    begin 
      @event.create_eliminations_lists
      @event.status = "eliminations"; @event.save 
      redirect_to eliminations_event_path, info: "Eliminations lists have been created."
    rescue => e
      redirect_to send("#{@event.status}_event_path"), danger: "#{e.message}"
    end 
  end 
  
  def delete_eliminations_lists
    @event.eliminations_lists.destroy_all
    @event.status = "competitors"; @event.save
    redirect_to competitors_event_path(@event)
  end
  
end