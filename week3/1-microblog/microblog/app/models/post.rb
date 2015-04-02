class Post < ActiveRecord::Base
  validates :body, length: { maximum: 256 }
  has_many :maps
  has_many :tags, through: :maps
end
