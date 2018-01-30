class EventCompetitorsController < ApplicationController
  before_action :set_event, :authorize_event
  before_action { check_status('competitors') }

  def index
    @competitors_from_db = Competitor.search(params[:search])
  end

  def create
    @competitor = Competitor.find(params[:competitor_id])
    @event.competitors << @competitor unless @event.competitors.include?(@competitor)
    respond_to do |format|
      format.html { redirect_to competitors_event_path(event) }
      format.js {}
    end
  end

  def destroy
    @competitor = Competitor.find(params[:competitor_id])
    @event.competitors.delete(@competitor)
    respond_to do |format|
      format.html { redirect_to competitors_event_path(event) }
      format.js {}
    end
  end

end