ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'capybara/rails'
require 'capybara/minitest'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
  def is_logged_in?
    !session[:user_id].nil?
  end 
  
  def login_as_marcin
    post sessions_path, params: { email: users(:marcin).email, password: 'marcin' }
    users(:marcin)
  end
  
  def login(name, password)
    post sessions_path, params: { email: users(name).email, password: password }
    users(name)
  end 
  
  def new_event 
    post events_path, params: { event: { name: 'Puchar Polski', place: 'Tarnovia' } }
    Event.last
  end
  
end


