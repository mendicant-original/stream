class User < ActiveRecord::Base
  has_many :articles, :foreign_key => :author_id
  has_many :authorizations

  attr_accessible :name, :github, :email, :twitter, :location, :about

  def editable_by?(user)
    user.admin? || user == self
  end
end
