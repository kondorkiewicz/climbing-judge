class Result < ApplicationRecord
  belongs_to :event
  belongs_to :competitor

  POINTS = [
            100, 80, 65, 55, 51, 47, 43, 40, 37, 34, 
            31, 28, 26, 24, 22, 20, 18, 16, 14, 12,
            10, 9, 8, 7, 6, 5, 4, 3, 2, 1
            ] 
            
  def self.sex(sex)
    select { |result| result.competitor.sex == sex }.sort_by { |res| res.place }
  end
  
  def self.compute_results(event, sex)
    results = gather_results(event, sex)
    results.each do |comp| 
      create(competitor_id: comp.competitor.id, event_id: event.id, place: comp.place, points: POINTS[comp.place - 1] )
    end 
  end 
  
  def self.gather_results(event, sex) 
    el_res = event.eliminations_results.sex(sex) 
    sf_res = event.round_results('sf', sex) unless event.round_list('sf', sex).nil?
    res = event.round_results('f', sex)
    finalists = res.map { |res| res.competitor_id }
    if sf_res 
      sf_res.each { |comp| res << comp unless finalists.include?(comp.competitor_id) }
      semi_finalists = sf_res.map { |res| res.competitor.id }
      el_res.each  { |comp| res << comp unless semi_finalists.include?(comp.competitor_id) }
    else 
      el_res.each { |comp| res << comp unless finalists.include?(comp.competitor_id) }
    end 
    res
  end 
  
end
