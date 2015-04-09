class Post < ActiveRecord::Base
  validates :body, length: { maximum: 256 }
  has_many :tags, dependent: :destroy
end
