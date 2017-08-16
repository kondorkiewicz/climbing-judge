class CompetitorsController < ApplicationController
  
  def create
    @competitor = Competitor.new(competitor_params)
    @event = Event.find(params[:event_id])
    respond_to do |format|
      if @competitor.save
        @event.competitors << @competitor
        format.html { redirect_to competitors_event_path(@event), success: 'Competitor was successfully created.' }
        format.json { render :show, status: :created, location: @competitor }
      else
        format.html { redirect_to competitors_event_path(@event), danger: 'Competitor is invalid!' }
        format.json { render json: @competitor.errors, status: :unprocessable_entity }
      end
    end
  end 
  
  private 
  
  def competitor_params
    params.require(:competitor).permit(:name, :surname, :date_of_birth, :sex, :club)
  end
  
end