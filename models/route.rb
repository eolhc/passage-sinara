class Route < ActiveRecord::Base
  belongs_to :location, dependent: :destroy
  has_many :steps
  has_many :votes
  has_one :users

end
