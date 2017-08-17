class List < ApplicationRecord
  belongs_to :event
  has_many :scores
  
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
    half = first_list.scores.size / 2 + 1
    first_list.scores.size.even? ? start_number = half : start_number = half + 1 
    first_list.scores.sort_by { |score| score.start_number }
    first_list.scores.each.with_index(1) do |score, i|
      start_num = 1 if i == half
      list.scores << Score.create(competitor_id: score.competitor_id, start_number: start_number, score: 0)
      start_number += 1 
    end
  end 
  
end
