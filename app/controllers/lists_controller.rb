class ListsController < ApplicationController
  before_action :set_event, except: :show
  
  def create_eliminations_lists 
    @event.create_eliminations_lists
    @event.status = "eliminations"
    respond_to do |format|
      if @event.save
        format.html { redirect_to eliminations_event_path(@event) }
        format.js {}
      else 
        format.html { redirect_to competitors_event_path(@event), flash: {danger: "Lists haven't been created!"} }
      end 
    end 
  end 
  
  def create_finals_lists 
    comps_number = params[:comps_number].to_i
    @event.create_finals_list('M', comps_number)
    @event.create_finals_list('F', comps_number)
    path = @event.status
    comps_number == 8 ? @event.status = "finals" : @event.status = "semi_finals"
    respond_to do |format|
      if @event.save 
        format.html { redirect_to send("#{@event.status}_event_path") }
        format.js {}
      else 
        format.html { redirect_to send("#{path}_event_path"), 
                  flash: { warning: "#{@event.status.titleize} lists haven't been created!"} }
      end
    end 
  end 
  
  def delete_eliminations_lists
    @event.eliminations_lists.destroy_all
    @event.status = "competitors"; @event.save
    redirect_to competitors_event_path(@event)
  end
  
  def delete_semi_finals_lists
    @event.lists.where(round: 'sf').destroy_all
    @event.status = "eliminations_results"; @event.save
    redirect_to eliminations_results_event_path(@event)
  end
  
  def delete_finals_lists
    @event.lists.where(round: 'f').destroy_all
    if @event.lists.where(round: 'sf').empty? 
      @event.status = "eliminations_results"; @event.save
      redirect_to eliminations_results_event_path(@event)
    else 
      @event.status = "semi_finals"; @event.save
      redirect_to semi_finals_event_path(@event)
    end  
  end 
  
  def show
    @list = List.find(params[:id])
    respond_to do |format|
      format.html
      format.pdf do 
        if params[:type]
          pdf = ResultsListPdf.new(@list)
        else 
          pdf = StartingListPdf.new(@list)
        end 
        send_data pdf.render, filename: "list_#{@list.id}.pdf",
                              type: "application/pdf",
                              disposition: "inline"
      end 
    end 
  end 
  
  private 
  
  def set_event 
    @event = Event.find(params[:id])
  end
  
end 