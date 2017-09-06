class CompetitorsController < ApplicationController
  
  def index
    @competitors = Competitor.all
    @men = Competitor.sex('M')
    @women = Competitor.sex('F')
  end
  
  def show
    @competitor = Competitor.find(params[:id])
    @results = Result.where(competitor_id: @competitor.id)
  end
  
  def create
    @competitor = Competitor.new(competitor_params)
    @event = Event.find(params[:event_id])
    respond_to do |format|
      if @competitor.save
        @event.competitors << @competitor if @event
        format.html { redirect_to competitors_event_path(@event) }
        format.json { render :show, status: :created, location: @competitor }
      else
        format.html { redirect_to competitors_event_path(@event), danger: 'Competitor is invalid!' }
        format.json { render json: @competitor.errors, status: :unprocessable_entity }
      end
    end
  end 
  
  private 
  
  def competitor_params
    params.require(:competitor).permit(:name, :surname, :birth_date, :sex, :club)
  end
  
end