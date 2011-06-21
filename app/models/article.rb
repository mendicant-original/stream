class Article < ActiveRecord::Base
  belongs_to :author, :class_name => "User"

  has_many :taggings
  has_many :tags, :through => :taggings

  validates_presence_of :title, :url, :body
  with_options :allow_blank => true do |opt|
    opt.validates_length_of :title, :minimum => 3
    opt.validates_format_of :url, :with => URI.regexp
  end

  attr_accessor :tag_list

  def editable_by?(user)
    user.admin? || user == author
  end
end
