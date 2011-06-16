class ArticlesController < ApplicationController
  before_filter :user_required, :only => [:new]

  def index
    @articles = Article.order("created_at").all
  end

  def new
    @article = Article.new(:author => current_user) 
  end

  def edit
    @article = Article.find(params[:id])
    unless @article.author.try(:admin) || current_user == @article.author
      flash[:error] = "You can't edit this article!"
      redirect_to root_path
    end
  end

  def show
    @article = Article.find(params[:id])
  end


end
