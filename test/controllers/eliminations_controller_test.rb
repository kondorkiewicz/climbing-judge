require 'test_helper'

class EliminationsControllerTest < ActionDispatch::IntegrationTest
  
  def setup 
    @event = events(:MP)
    login(:konrad, 'password')
  end 
  
  test 'should not create eliminations lists for less than 2 competitors' do
    get create_eliminations_lists_event_path(@event)
    assert_response :redirect 
    follow_redirect!
    assert_select "div", "There should be at least two competitors in each category!"
  end 
  
  test 'should create eliminations lists with 2 competitors in each category' do
    @event.competitors << competitors(:konrad, :kinga, :kajetan, :maja)
    get create_eliminations_lists_event_path(@event)
    assert_response :redirect 
    follow_redirect!
    assert_select "div", "Eliminations lists have been created."
    assert_select "h4", "Eliminations"
    assert_equal 'eliminations', Event.last.status
  end 
  
  test 'should not allow to delete eliminations lists with wrong status' do
    get delete_eliminations_lists_event_path(@event)
    assert_response :redirect 
    follow_redirect!
    assert_select "div", "Prohibited action!"
  end 
  
  test 'should allow to delete eliminations lists with right status' do
    @event.update_attribute(:status, 'eliminations')
    get delete_eliminations_lists_event_path(@event)
    assert_response :redirect 
    follow_redirect!
    assert_select 'h2', 'Adding Competitors' 
  end 
  
  test 'should not create eliminations lists twice' do 
    @event.competitors << competitors(:konrad, :kinga, :kajetan, :maja)
    get create_eliminations_lists_event_path(@event)
    follow_redirect!
    assert_equal 'eliminations', Event.last.status
    get create_eliminations_lists_event_path(@event)
    assert_response :redirect
    follow_redirect! 
    assert_select 'div', 'Prohibited action!' 
  end 
  
  test 'should not visit eliminations with wrong status' do 
    get eliminations_event_path(@event)
    assert_response :redirect
    follow_redirect! 
    assert_select 'div', 'Prohibited action!' 
  end 
  
  
  
  

end 