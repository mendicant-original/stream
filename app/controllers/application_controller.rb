class ApplicationController < ActionController::Base
  protect_from_forgery

  private

  def authenticate_admin_user!
    unless current_user.try(:admin)
      flash[:alert] = "You are not authorize to view this area"
      redirect_to root_path
    end
  end

  def current_admin_user
    current_user if current_user.try(:admin)
  end

  def current_user
    @current_user ||= User.find_by_id(session[:user_id])
  end

  def signed_in?
    !!current_user
  end

  def sign_in_path(provider="github")
    "/auth/#{provider}"
  end

  helper_method :current_user, :signed_in?, :sign_in_path

  def current_user=(user)
    @current_user = user
    session[:user_id] = user.try(:id)
  end

  def user_required
    unless signed_in?
      flash[:alert] = "Please sign in to continue!"
      store_location
      redirect_to sign_in_path
    end
  end

  def store_location
    session[:return_to] = request.fullpath
  end

  def redirect_back_or_default(default)
    redirect_to(session[:return_to] || default)
    session[:return_to] = nil
  end
end
