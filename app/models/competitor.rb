class Competitor < ApplicationRecord
  
  def self.search(search)
    if search 
      where("name LIKE ? OR surname LIKE ?", "#{search}%", "#{search}%")
    end 
  end
  
  def self.sex(sex)
    where(sex: sex).sort_by { |comp| comp.surname }
  end
  
end
