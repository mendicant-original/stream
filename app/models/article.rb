class Article < ActiveRecord::Base
  belongs_to :author, :class_name => "User"

  has_many :taggings
  has_many :tags, :through => :taggings
end
