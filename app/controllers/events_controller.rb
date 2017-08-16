class EventsController < ApplicationController
  before_action :set_event, except: [:create, :index, :new]
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
  
  def competitors 
    @competitors_from_db = Competitor.search(params[:search]) 
  end 
  
  def add_competitor
    @competitor = Competitor.find(params[:competitor_id])
    @event.competitors << @competitor unless @event.competitors.include?(@competitor)
    respond_to do |format|
      format.html { redirect_to competitors_event_path(event) }
      format.js {}
    end 
  end
  
  def delete_competitor
    @competitor = Competitor.find(params[:competitor_id])
    @event.competitors.delete(@competitor)
    respond_to do |format|
      format.html { redirect_to competitors_event_path(event) }
      format.js {}
    end 
  end
  
  private 
  
  def set_event
    @event = Event.find(params[:id])
  end
  
  def event_params
    params.require(:event).permit(:name, :place)
  end
  
end