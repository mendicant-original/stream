class Tag < ActiveRecord::Base
  has_many :tagging
  has_many :article, :through => :tagging
end
