class ArticlesController < ApplicationController
  before_filter :user_required, :only => [:new, :create]
  before_filter :find_article, :authorized_users_only, :only => [:edit, :update, :destroy]
  before_filter :find_article, :only => [:show]
  
  def index
    @articles = Article.order("created_at").all
  end

  def show
  end
  
  def new
    @article = Article.new(:author => current_user) 
  end

  def create
  end
  
  def edit
    @article = Article.find(params[:id])
  end

  def update
  end

  def destroy
  end

  private
  
  def authorized_users_only
    unless current_user && (current_user.admin || current_user == @article.author)
      flash[:error] = "You can't edit this article!"
      redirect_to root_path
    end
  end
  
  def find_article
    @article = Article.find(params[:id])
  end

end
