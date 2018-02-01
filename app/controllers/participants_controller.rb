class ParticipantsController < ApplicationController

  def index
    @competitor = Competitor.new
    @event = Event.find(params[:event_id])
    @competitors = Competitor.search(params[:search])
  end

  def create
    @event = Event.find(params[:event_id])
    @competitor = Competitor.find(params[:competitor_id])
    @event.participants << @competitor unless @event.participants.include?(@competitor)
    respond_to do |format|
      format.html { redirect_to event_participants_path(@event) }
      format.js {}
    end
  end

  def destroy

  end

end