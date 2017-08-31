class Competitor < ApplicationRecord
  has_and_belongs_to_many :events
  validates :name, :surname, :sex, :club, :birth_date, presence: true 
  
  def full_name
    "#{name} #{surname}"
  end
  
  def self.search(search)
    if search 
      where("name LIKE ? OR surname LIKE ?", "#{search}%", "#{search}%")
    end 
  end
  
  def self.sex(sex)
    where(sex: sex).sort_by { |comp| comp.surname }
  end
  
end
