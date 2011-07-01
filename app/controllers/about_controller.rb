class AboutController < ApplicationController
  def index
    @users = User.includes(:articles).where(["articles.id IS NOT ?", nil]).order("name")
  end
end
