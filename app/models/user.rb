class User < ApplicationRecord
  has_secure_password
  has_many :events
  validates_uniqueness_of :email
  
  def self.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end
end