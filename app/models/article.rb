class Article < ActiveRecord::Base
  belongs_to :author, :class => "User" 

  has_many :tagging
  has_many :tag, :through => :tagging
end
