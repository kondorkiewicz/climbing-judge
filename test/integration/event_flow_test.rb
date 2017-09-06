require 'test_helper'

class EventFlowTest < ActionDispatch::IntegrationTest
  
  test "can see the welcome page" do 
    get "/"
    assert_select "h1", "Climbing Judge"
  end  
  
  test "not logged in user cannot create an event" do 
    get new_event_path
    assert_response :redirect
    follow_redirect!
    assert_response :success
    assert_select "div", "Not authorized" 
  end 
  
  test "logged in admin can see form for event" do 
    login(:konrad, 'password')
    get new_event_path
    assert_response :success
  end 
  
  test "not admin cannot create an event" do 
    login(:kinga, 'password2')
    assert_redirected_to root_path 
    follow_redirect!
    assert_select "div", "Logged in!"
    get new_event_path
    assert_redirected_to login_url 
    follow_redirect!
    assert_select "div", "Not authorized"
  end 
  
  test "logged in admin can create an event" do 
    login(:konrad, 'password')
    post events_path, params: { event: { name: 'Puchar Polski', place: 'Tarnovia' } }
    assert_response :redirect
    follow_redirect!
    assert_select "h2", "Adding Competitors"
  end 
  
  test "not authorized user should not view unfinished event" do
    post events_path, params: { event: { name: 'Puchar Polski', place: 'Tarnovia' } }
    get event_path("#{Event.last.id}")
    assert_redirected_to root_path
    follow_redirect!
    assert_select "div", "This event is not finished!"
  end
   
  test "new event should take authorized user to its competitors path" do
    login(:konrad, 'password')
    post events_path, params: { event: { name: 'Puchar Polski', place: 'Tarnovia' } }
    assert_redirected_to competitors_event_path("#{Event.last.id}")
  end
  
  

  
  

  
end
