require 'test_helper'
require 'exceptions'

class EventTest < ActiveSupport::TestCase
  include Exceptions 
  
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
  
  test "should not create eliminations lists without competitors" do 
    event = events(:MP) 
    exception = assert_raise(ClimbingError) { event.create_eliminations_lists }
    assert_equal 'There has to be at least one competitor in each category!', exception.message
  end
  
  test "there are four eliminations lists" do 
    assert_equal 4, @event.eliminations_lists.size
  end
  
  test "there are all competitors in each eliminations list" do 
    assert_equal @event.men.size, @event.list_scores('el_1', 'M').size
    assert_equal @event.list_scores('el_1', 'M').size, @event.list_scores('el_2', 'M').size
    assert_equal @event.women.size, @event.list_scores('el_1', 'F').size
    assert_equal @event.list_scores('el_1', 'F').size, @event.list_scores('el_2', 'F').size
  end
  
  test "each list has a proper name" do 
    assert_equal "First route (men)", @event.list('el_1', 'M').name 
    assert_equal "Second route (men)", @event.list('el_2', 'M').name
    assert_equal "First route (women)", @event.list('el_1', 'F').name
    assert_equal "Second route (women)", @event.list('el_2', 'F').name
  end
  
  test "competitor is on a proper place on both lists" do 
    assert_equal @event.list_scores('el_1', 'M')[0].competitor, @event.list_scores('el_2', 'M')[11].competitor
  end
  
  test "start numbers are properly added" do 
    score1 = @event.list_scores('el_1', 'M').where(start_number: 1)
  end
  
end
