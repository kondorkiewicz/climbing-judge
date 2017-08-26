class EliminationsResultsController < ApplicationController
  before_action :set_event
  before_action :authorize_event
  
  def index 
    @men_results = @event.eliminations_results.sex('M')
    @women_results = @event.eliminations_results.sex('F')
    if @men_results.empty? || @women_results.empty?
      redirect_to eliminations_event_path(@event), 
              flash: { warning: "There are no eliminations results!" }
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
    EliminationsResult.set_places_after_eliminations('M', @event)
    EliminationsResult.set_places_after_eliminations('F', @event)
    @event.status = "eliminations_results"
    respond_to do |format|
      if @event.save 
        format.html { redirect_to eliminations_results_event_path(@event) }
      else 
        format.html {redirect_to eliminations_event_path(@event), 
          flash: {warning: "Eliminations results haven't been computed!"}}
      end
    end 
  end
  
  def delete_eliminations_results 
    @event.eliminations_results.destroy_all
    @event.status = "eliminations"; @event.save 
    redirect_to eliminations_event_path, flash: { info: "Eliminations Results have been deleted!" }
  end 
  
  private 
  
  def set_event 
    @event = Event.find(params[:id])
  end 
  
end 