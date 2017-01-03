class Vote < ActiveRecord::Base
  belongs_to :user
  belongs_to :route
# positive or negative values - count them

  # def getPositiveVotes
  #   @positive =
  # end

end
