class List < ApplicationRecord
  belongs_to :event
  has_many :scores, :dependent => :destroy
  
  def start_list
    scores.sort_by { |score| score.start_number }
  end
  
  def results 
    scores.sort_by { |score| score.place }
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
      if scores.size > 1
        add_ex_aequo_points(place, scores)
      else 
        scores.each { |score| score.ex_points = score.place; score.save }
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
