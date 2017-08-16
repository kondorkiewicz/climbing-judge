class Competitor < ApplicationRecord
  
  def self.search(search)
    if search 
      where("name LIKE ? OR surname LIKE ?", "%#{search}%", "%#{search}%")
    end 
  end
  
end
