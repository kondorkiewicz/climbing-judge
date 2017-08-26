class User < ApplicationRecord
  has_secure_password
  has_many :events
  validates_uniqueness_of :email
end