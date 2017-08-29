require 'test_helper'

class CompetitorTest < ActiveSupport::TestCase
  test "should return full name" do
    competitor = competitors(:konrad)
    assert_equal "Konrad Ociepka", competitor.full_name
  end
end
