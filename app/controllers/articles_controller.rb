class ArticlesController < ApplicationController
  before_filter :user_required, :only => [:new, :create]

  def index
    @articles = Article.all
  end

  def new
    @article = current_user.articles.build
  end

  def edit
    @article = Article.find(params[:id])
  end

  def create
    @article = current_user.articles.build(params[:article])

    if @article.save
      redirect_to(root_path, :notice => 'Article was successfully created.')
    else
      render :action => "new"
    end
  end

  def update
    @article = Article.find(params[:id])

    if @article.update_attributes(params[:article])
      redirect_to(root_path, :notice => 'Article was successfully updated.')
    else
      render :action => "edit"
    end
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy

    redirect_to(root_path)
  end

  private

  # TODO: remove this stub method after integrate entire auth.
  def current_user
    @current_user ||= User.last
  end
end
