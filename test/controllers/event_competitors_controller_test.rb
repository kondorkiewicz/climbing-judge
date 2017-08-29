require 'test_helper'

class EventCompetitorsControllerTest < ActionDispatch::IntegrationTest
  
  def add_competitor(event_id, competitor_id) 
    get add_competitor_event_path(event_id, competitor_id: competitor_id), 
        xhr: true
  end
  
  def setup
    @user = login_as_marcin
    @event = new_event
  end
  
  test "should add competitor to the event" do 
    competitor = competitors(:kajetan)
    add_competitor(@event.id, competitor.id)
    assert_equal "text/javascript", @response.content_type
    assert_equal 1, @event.competitors.size
    assert_equal @event.user_id, @user.id
  end
  
  test "should properly add competitors from fixtures" do
    assert_equal 0, @event.competitors.size
    assert_equal 0, @event.men.size
    comps = Competitor.all
    comps.each { |comp| add_competitor(@event.id, comp.id ) }
    assert_equal 22, @event.men.size 
    assert_equal 20, @event.women.size
  end
  
end 