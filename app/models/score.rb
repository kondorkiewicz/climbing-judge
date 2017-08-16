class Score < ApplicationRecord
  belongs_to :list
  belongs_to :competitor
end
