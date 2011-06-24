class Article < ActiveRecord::Base
  belongs_to :author, :class_name => "User"

  has_many :taggings, :dependent => :delete_all
  has_many :tags, :through => :taggings

  validates_presence_of :title, :url, :body
  with_options :allow_blank => true do |opt|
    opt.validates_length_of :title, :minimum => 3
    opt.validates_format_of :url, :with => URI.regexp
  end

  def editable_by?(user)
    user.admin? || user == author
  end

  attr_writer :tag_list
  before_save :update_tags, :if => :tag_list?

  def tag_list
    @tag_list ||= tags.map(&:name).join(', ')
  end

  private

  def tag_list?
    @tag_list.present?
  end

  def update_tags
    self.tags = tag_list.split(',').reject(&:blank?).
      each(&:strip!).map { |t| Tag.find_or_create_by_name(t) }
  end
end
