class EventsController < ApplicationController
  before_action :authorize, only: [:new, :edit, :create]
  
  def new 
    @event = Event.new 
  end 
  
  def create
    @event = Event.new(event_params)
    respond_to do |format|
      if @event.save
        session[:event_id] = @event.id
        format.html { redirect_to competitors_event_path(@event), notice: 'Event was successfully created.' }
        format.json { render :show, status: :created, location: @event }
      else
        format.html { render :new }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end
  
  private 
  
  def event_params
    params.require(:event).permit(:name, :place)
  end
  
end