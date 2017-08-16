class Event < ApplicationRecord
  has_many :lists 
  has_and_belongs_to_many :competitors
  
  def men 
    competitors.where(sex: 'M')
  end
  
  def women 
    competitors.where(sex: 'F')
  end
  
end
