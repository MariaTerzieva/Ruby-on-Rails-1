class Post < ActiveRecord::Base
  validates :body, length: { maximum: 256 }
  has_and_belongs_to_many :tags, join_table: :maps
end
