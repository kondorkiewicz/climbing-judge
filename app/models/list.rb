class List < ApplicationRecord
  belongs_to :event
  has_many :scores
end
