require 'test_helper'

class EventsControllerTest < ActionDispatch::IntegrationTest
  
  test "should get index" do
    get events_url
    assert_response :success
    assert_select "strong", text: "Events"
  end

  
end