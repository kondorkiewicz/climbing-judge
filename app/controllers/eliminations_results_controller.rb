class EliminationsResultsController < ApplicationController
  before_action :set_event
  before_action :authorize_event
  before_action :check_finished_status
  before_action only: [:compute_eliminations_results] { check_status('eliminations') }
  before_action only: [:delete_eliminations_results, :index] { check_status('eliminations_results') }
  
  def index 
    @men_results = @event.eliminations_results.sex('M')
    @women_results = @event.eliminations_results.sex('F')
    if @men_results.empty? || @women_results.empty?
      redirect_to eliminations_event_path(@event), warning: "There are no eliminations results!" 
    end
    params[:sex] == 'Men' ? @results = @men_results : @results = @women_results
    respond_to do |format|
      format.html 
      format.pdf do 
        pdf = EliminationsResultsPdf.new(@results, params[:sex])
        send_data pdf.render, filename: "#{@event.name}_eliminations_results_(#{params[:sex]}).pdf",
                              type: "application/pdf",
                              disposition: "inline"
      end 
    end
  end 
  
  def compute_eliminations_results
    begin
      EliminationsResult.set_places_after_eliminations('M', @event)
      EliminationsResult.set_places_after_eliminations('F', @event)
      @event.status = "eliminations_results"; @event.save
      redirect_to eliminations_results_event_path, info: "Eliminations results have been computed."
    rescue => e 
      redirect_to send("#{@event.status}_event_path"), danger: "#{e.message}"
    end 
  end
  
  def delete_eliminations_results
    @event.eliminations_results.destroy_all
    @event.status = "eliminations"; @event.save 
    redirect_to eliminations_event_path, info: "Eliminations Results have been deleted!" 
  end 
  
end 