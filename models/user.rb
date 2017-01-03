class User < ActiveRecord::Base
  has_secure_password

  # active record validations

  has_many :followers
  has_many :votes
  belongs_to :routes
  # 
  # def canVote(route)
  #   theRoute = Route.find(route.id)
  #
  # end

end
