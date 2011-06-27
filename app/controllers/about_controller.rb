class AboutController < ApplicationController
  
  def index
    @users = User.find(:all, :order => "name desc")
    @users.keep_if{ |user| user.articles.size > 0 }
  end
  
end
