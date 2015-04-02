class Tag < ActiveRecord::Base
  has_many :maps
  has_many :posts, through: :maps
end
