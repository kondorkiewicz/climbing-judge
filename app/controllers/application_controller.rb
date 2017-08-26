class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  add_flash_types :success, :warning, :danger, :info
  private 
  
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
  
end