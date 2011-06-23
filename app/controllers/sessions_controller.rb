class SessionsController < ApplicationController
  before_filter :get_auth_hash, :only => [:create]
  
  def new
    
  end
  
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
    
   #TODO add before_filter for checking uni-web permissions
   
end
