class EventsController < ApplicationController
  before_action :authorize, only: [:new, :create, :destroy]
  
  def index 
    @events = Event.all.where(status: "finished")
  end 
  
  def new 
    @event = Event.new 
  end 
  
  def create
    @event = Event.new(event_params)
    @event.user_id = current_user.id
    @event.status = "competitors"
    respond_to do |format|
      if @event.save
        format.html { redirect_to competitors_event_path(@event), success: 'Event was successfully created.' }
        format.json { render :show, status: :created, location: @event }
      else
        format.html { render :new }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def show
    @event = Event.find(params[:id])
    if current_user && @event.user_id == current_user.id && @event.status != "finished"
      redirect_to send("#{@event.status}_event_path")
    elsif @event.status != "finished" 
      redirect_to root_path, warning: "This event is not finished!"
    else 
      @men = @event.results.sex('M')
      @women = @event.results.sex('F')
    end 
  end  
  
  def destroy
    @event = Event.find(params[:id])
    @event.destroy 
    redirect_to root_path, info: "Event has been destroyed."
  end

  private 
  
  def event_params
    params.require(:event).permit(:name, :place)
  end
  
end