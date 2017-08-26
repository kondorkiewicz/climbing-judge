module EventHelper 
  
  def enough_scores?(scores)
    scores.all? do |score| 
      score.scores.all? { |s| s.score > 0 }
    end 
  end
  
  def scores_remaining(scores)
    scores_remaining = 0
    scores.each do |score|
      scores_remaining += score.scores.select { |s| s.score == 0 }.size
    end 
    scores_remaining
  end 

  
end 