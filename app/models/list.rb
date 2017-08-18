class List < ApplicationRecord
  belongs_to :event
  has_many :scores, :dependent => :destroy
  
  def self.create_eliminations_lists(event)
    m1 = create_first_list(event.men, event.id)
    f1 = create_first_list(event.women, event.id)
    create_second_list(m1)
    create_second_list(f1)
  end 
  
  def self.create_first_list(competitors, event_id)
    list = create(event_id: event_id, round: 'el_1', sex: competitors.first.sex)
    competitors.shuffle 
    competitors.each.with_index(1).map do |competitor, start_number|
      list.scores << Score.create(competitor_id: competitor.id, start_number: start_number, score: 0)
    end
    list
  end
  
  def self.create_second_list(first_list)
    list = create(event_id: first_list.event.id, round: 'el_2', sex: first_list.sex)
    first_list.scores.sort_by { |score| score.start_number }
    half = first_list.scores.size / 2 + 1
    first_list.scores.size.even? ? start_number = half : start_number = half + 1 
    first_list.scores.each.with_index(1) do |score, i|
      start_number = 1 if i == half
      list.scores << Score.create(competitor_id: score.competitor_id, start_number: start_number, score: 0)
      start_number += 1 
    end
  end 
  
  def set_places
    count = 1; place = 1
    scores.sort_by {|score| score.score}.reverse.each_cons(2) do |a, b|
      if a.score == b.score
        a.place = place; b.place = place
        count += 1
        a.save; b.save
      else 
        a.place = place; b.place = place + count
        place += count; count = 1
        a.save; b.save 
      end 
    end 
  end
  
  def set_ex_aequo_points
    ex_aequo_places = scores.group_by { |score| score.place }
    ex_aequo_places.map do |place, scores|
      if comps.size > 1
        add_ex_aequo_points(place, scores)
      else 
        scores.each { |score| score.ex_points = comp.place; comp.save }
      end 
    end
  end
  
  def add_ex_aequo_points(place, scores)
    limit = place + scores.size - 1
    range = place < limit ? place..limit : limit..place 
    points = [*range].inject(:+) / scores.size.to_f
    scores.each do |score|
      score.ex_points = points 
      score.save
    end 
  end
  
end
