class SessionsController < ApplicationController
  before_filter :get_auth_hash, :check_permissions, :only => :create

  def create
    unless auth = Authorization.find_from_hash(@auth)
      # Create a new user or add an auth to existing user, depending on
      # whether there is already a user signed in.
      auth = Authorization.create_from_hash(@auth, current_user)
    end

    # Log the authorizing user in.
    self.current_user = auth.user

    redirect_back_or_default root_path
  end

  def destroy
    self.current_user = nil

    redirect_to root_path
  end

  private

  def get_auth_hash
    @auth = request.env['omniauth.auth']
  end

  def check_permissions
    nick = @auth['user_info']['nickname']
    user = UniversityWeb::User.find_by_github(nick)
    alert = \
      if user.nil?
        "Your github account is not registered on University-web"
      elsif !user.alumnus && !user.staff
        "You are not authorized as a user on Flow"
      end
    redirect_to root_path, :alert => alert if alert
  end
end
