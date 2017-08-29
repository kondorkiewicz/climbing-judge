class Score < ApplicationRecord
  belongs_to :list
  belongs_to :competitor
  validates :score, :numericality => { :greater_than_or_equal_to => 0 }
  
  def results 
    sort_by { |score| score.place }
  end
end
