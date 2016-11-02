class Image < ActiveRecord::Base
  belongs_to :step, dependent: :destroy,

end
