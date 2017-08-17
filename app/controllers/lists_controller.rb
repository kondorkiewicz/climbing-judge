class ListsController < ApplicationController
  
  def create_eliminations_lists 
    event = Event.find(params[:id])
    List.create_eliminations_lists(event)
    respond_to do |format|
      format.html { redirect_to eliminations_event_path(event) }
      format.js {}
    end 
  end 
  
end 