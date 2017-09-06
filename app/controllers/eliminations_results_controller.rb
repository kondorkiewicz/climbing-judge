class EliminationsResultsController < ApplicationController
  before_action :set_event, :authorize_event, :check_finished_status
  before_action only: [:compute_eliminations_results] { check_status('eliminations') }
  before_action except: [:compute_eliminations_results] { check_status('eliminations_results') }
  
  def index 
    @men_results = @event.eliminations_results.sex('M')
    @women_results = @event.eliminations_results.sex('F')
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
    if correct_scores?(@event.eliminations_lists)
      EliminationsResult.set_places_after_eliminations('men', @event)
      EliminationsResult.set_places_after_eliminations('women', @event)
      @event.update_attribute(:status, 'eliminations_results')
      redirect_to eliminations_results_event_path, 
        info: "Eliminations results have been computed."
    else 
      redirect_to eliminations_event_path,
        warning: 'Every score has to be greater than zero!'
    end 
  end
  
  def delete_eliminations_results
    @event.eliminations_results.destroy_all
    @event.status = "eliminations"; @event.save 
    redirect_to eliminations_event_path, 
      info: "Eliminations Results have been deleted!" 
  end 
  
end 