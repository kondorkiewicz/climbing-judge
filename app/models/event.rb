class Event < ApplicationRecord
  has_many :lists 
  has_and_belongs_to_many :competitors
end
