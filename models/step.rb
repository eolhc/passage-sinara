class Step < ActiveRecord::Base
  belongs_to :route, dependent: :destroy,
  has_one :image

end
