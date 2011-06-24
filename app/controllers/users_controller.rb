class UsersController < ApplicationController
  before_filter :fetch_user, :except => :index
  before_filter :authorized, :except => [:index, :show, :edit]

  def index
    @users = User.all
  end

  def show
  end

  def edit
  end

  def update
    if @user.update_attributes(params[:user])
      redirect_to(@user, :notice => 'User was successfully updated.')
    else
      render :action => "edit"
    end
  end

  def destroy
    @user.destroy
    redirect_to(users_url, :notice => 'User was successfully deleted.')
  end

  private

  def fetch_user
    @user = User.find(params[:id])
  end

  def authorized
    unless @user.editable_by? current_user
      flash[:alert] = "Permission denied"
      redirect_to(users_path)
    end
  end
end
