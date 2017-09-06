class FinalsController < ApplicationController
  before_action :set_event, :authorize, :authorize_event, :check_finished_status
  before_action except: [:create_finals_lists] { check_status('finals') }
  
  def finals 
    @m = @event.list('finals', 'men')
    @f = @event.list('finals', 'women')
  end 
  
  def create_finals_lists 
    if @event.status != 'semi_finals' && @event.status != 'eliminations_results'
      redirect_to send("#{@event.status}_event_path"), warning: 'Prohibited action!'
    elsif correct_scores?(@event.round_lists('semi_finals')) || @event.status == 'eliminations_results'
      @event.create_finals_list('men')
      @event.create_finals_list('women')
      @event.update_attribute(:status, 'finals')
      redirect_to finals_event_path, info: "Lists have been created."
    else 
      redirect_to semi_finals_event_path, 
        warning: 'Every score has to be greater than zero!'
    end 
  end 
  
  def delete_finals_lists
    @event.lists.where(round: 'finals').destroy_all
    if @event.lists.where(round: 'semi_finals').empty? 
      @event.update_attribute(:status, 'eliminations_results')
    else 
      @event.update_attribute(:status, 'semi_finals')
    end  
    redirect_to send("#{@event.status}_event_path"), 
      info: "Lists have been deleted."
  end 

end