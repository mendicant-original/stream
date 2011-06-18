class ArticlesController < ApplicationController
  before_filter :user_required, :only => [:new, :create, :edit, :update]
  before_filter :find_article, :authorized_users_only, :only => [:edit, :update]

  def index
    @articles = Article.all
  end

  def new
    @article = current_user.articles.build
  end

  def edit
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

  def authorized_users_only
    if current_user != @article.user
      redirect_to root_path,
        :alert => "You are not authorized to edit other user's articles!"
    end
  end

  # TODO: remove this stub method after integrate entire auth.
  def current_user
    @current_user ||= User.last
  end

  def find_article
    @article = Article.find(params[:id])
  end
end
