class User < ActiveRecord::Base
  has_many :articles, :foreign_key => :author_id
  has_many :authorizations
end
