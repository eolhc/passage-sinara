

class User < ActiveRecord::Base
  has_secure_password

  has_many :followers
  has_many :votes
  belongs_to :routes

end
