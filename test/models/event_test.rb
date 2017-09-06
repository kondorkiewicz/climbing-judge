require 'test_helper'

class EventTest < ActiveSupport::TestCase
  
  def setup
    @event = events(:PP)
    @event.create_eliminations_lists 
  end
  
  test "should not save event without a name" do
    event = Event.new
    assert_not event.save, "Saved event without a title"
  end
  
  test "should have competitors" do 
    assert_equal 41, @event.competitors.size 
  end
  
  test "should divide competitors by sex" do 
    assert_equal 21, @event.men.size
    assert_equal 20, @event.women.size 
  end
  
  test "there are four eliminations lists" do 
    assert_equal 4, @event.eliminations_lists.size
  end
  
  test "there are all competitors in each eliminations list" do 
    assert_equal @event.men.size, @event.list_scores('first_route', 'men').size
    assert_equal @event.list_scores('first_route', 'men').size, @event.list_scores('second_route', 'men').size
    assert_equal @event.women.size, @event.list_scores('first_route', 'women').size
    assert_equal @event.list_scores('first_route', 'women').size, @event.list_scores('second_route', 'women').size
  end
  
  test "competitor is on a proper place on both lists" do 
    assert_equal @event.list_scores('first_route', 'men')[0].competitor, @event.list_scores('second_route', 'men')[11].competitor
  end
  
end
