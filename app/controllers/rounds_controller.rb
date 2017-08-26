class RoundsController < ApplicationController
  before_action :set_event
  before_action :authorize
  before_action :authorize_event
  
  def eliminations  
    @m1 = @event.round_list('el_1', 'M')
    @f1 = @event.round_list('el_1', 'F')
    @m2 = @event.round_list('el_2', 'M')
    @f2 = @event.round_list('el_2', 'F')
    if @m1.nil? || @f1.nil? || @m2.nil? || @f2.nil?
      redirect_to competitors_event_path(@event), flash: {warning: 'There are no eliminations lists!' }
    elsif @event.status != "eliminations"
      redirect_to send("#{@event.status}_event_path"),
              flash: { warning: 'You need to delete scores from a round you are currently in to go back!'}
    end  
  end 
  
  def semi_finals
    @m = @event.round_list('sf', 'M')
    @f = @event.round_list('sf', 'F')
    render template: 'rounds/finals'
    if @m.nil? || @f.nil?
      redirect_to eliminations_results_event_path(@event), 
            flash: {warning: 'There are no lists for Semi-Finals!' }   
     elsif @event.status != "semi_finals"
      redirect_to send("#{@event.status}_event_path"),
              flash: { warning: 'You need to delete scores from a round you are currently in to go back!'}
    end  
  end 
  
  def finals 
    @m = @event.round_list('f', 'M')
    @f = @event.round_list('f', 'F')
    if @m.nil? || @f.nil?
      redirect_to send("#{@event.status}_event_path"), 
              flash: {warning: 'There are no lists for finals!' }   
    elsif @event.status == "finished"
      redirect_to event_path
    end 
  end 
  
  private 
  
  def set_event 
    @event = Event.find(params[:id])
  end 
  
end