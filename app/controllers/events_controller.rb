class EventsController < ApplicationController
  before_action :set_event, except: [:new, :create]
  before_action :authorize, only: [:new, :create]
  
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
  
  def eliminations 
    @m1 = @event.round('el_1', 'M')
    @f1 = @event.round('el_1', 'F')
    @m2 = @event.round('el_2', 'M')
    @f2 = @event.round('el_2', 'F')
  end 
  
  def semi_finals 
    @m = @event.round('sf', 'M')
    @f = @event.round('sf', 'F')
  end 
  
  def finals 
    @m = @event.round('f', 'M')
    @f = @event.round('f', 'F')
  end 
  
  private 
  
  def event_params
    params.require(:event).permit(:name, :place)
  end
  
  def set_event 
    @event = Event.find(params[:id])
  end 
  
end