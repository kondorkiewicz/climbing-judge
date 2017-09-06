class SemiFinalsController < ApplicationController
  before_action :set_event, :authorize, :authorize_event, :check_finished_status
  before_action only: [:create_semi_finals_lists] { check_status('eliminations_results') }
  before_action except: [:create_semi_finals_lists] { check_status('semi_finals') }
  
  def semi_finals
    @m = @event.list('semi_finals', 'men')
    @f = @event.list('semi_finals', 'women')
  end 
  
  def create_semi_finals_lists
    @event.create_semi_finals_list('men')
    @event.create_semi_finals_list('women')
    @event.update_attribute(:status, 'semi_finals')
    redirect_to semi_finals_event_path, info: "Lists have been created." 
  end 
  
  def delete_semi_finals_lists
    @event.lists.where(round: 'semi_finals').destroy_all
    @event.status = "eliminations_results"; @event.save
    redirect_to eliminations_results_event_path(@event)
  end
  
end 