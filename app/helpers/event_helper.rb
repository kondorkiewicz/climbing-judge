module EventHelper 
  
  def enough_scores?(scores)
    scores.all? do |score| 
      score.all? { |s| s.score > 0 }
    end 
  end
  
end 