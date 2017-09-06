class EliminationsResult < ApplicationRecord
  belongs_to :competitor
  belongs_to :event
  
  def self.sex(sex)
    select { |result| result.competitor.sex == sex }
  end
  
  def self.set_places_after_eliminations(sex, event)
    scores = event.list_scores('first_route', sex) + event.list_scores('second_route', sex)
    points = set_points(scores, event.id)
    set_places(points)
  end
  
  def self.set_points(scores, event_id)
    points = []
    scores = scores.group_by { |score| score.competitor_id }
    scores.map do |competitor_id, scores|
      scores.each_cons(2) do |a, b|
        points << create(competitor_id: competitor_id, event_id: event_id, first_route_place: a.place, second_route_place: b.place, 
        points: Math.sqrt(a.ex_points + b.ex_points))
      end
    end
    points 
  end
  
  def self.set_places(points)
    points.sort_by! { |comp| comp.points }
    count = 1; place = 1
    points.each_cons(2) do |comp1, comp2|
      if comp1.points == comp2.points
        comp1.place = place; comp2.place = place
        count += 1
        comp1.save; comp2.save
      else 
        comp1.place = place; comp2.place = place + count
        place += count; count = 1
        comp1.save; comp2.save
      end 
    end 
  end
  
end