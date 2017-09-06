class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  add_flash_types :success, :warning, :danger, :info
  
  private
  
  def set_event 
    @event = Event.find(params[:id])
  end 
  
  def check_finished_status
    redirect_to event_path, info: "This event is finished!" if @event.status == "finished"
  end
  
  def check_status(status)
    redirect_to send("#{@event.status}_event_path"), warning: "Prohibited action!" unless @event.status == status
  end 
  
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end 
  helper_method :current_user
  
  def authorize 
    redirect_to login_url, alert: "Not authorized" unless current_user && current_user.admin
  end 
  
  def authorize_event 
    redirect_to root_path, alert: "It's not your event!" unless @event.user_id == current_user.id
  end
  
  def correct_scores?(lists)
    lists.all? { |list| list.scores.all? { |score| score.score > 0 } }
  end 
  
end