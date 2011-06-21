require 'uri'

class SessionsController < ApplicationController
  
  AUTH_PROVIDER_CHAIN = {'github' => '/auth/universityweb?uid=:uid'}
  
  def new
    
  end
  
  def create
    auth = request.env['omniauth.auth']
    
    if url = auth_redirect(@params['provider'], auth)
      redirect_to url
    else

      if Authorization.valid_for_hash(auth)
      
        unless @auth = Authorization.find_from_hash(auth)
          # Create a new user or add an auth to existing user, depending on
          # whether there is already a user signed in.
          @auth = Authorization.create_from_hash(auth, current_user)
        end
        
        # Log the authorizing user in.
        self.current_user = @auth.user
      end
      
      redirect_back_or_default root_path
      
    end
      
  end
  
  def destroy
    self.current_user = nil
    
    redirect_to root_path
  end
  
  private
  
  def auth_redirect(provider, auth)
    return unless pattern = AUTH_PROVIDER_CHAIN[provider]
    pattern.gsub(/:(\w+)/) do |s|
      URI.escape(auth[$1].to_s || $1)
    end
  end
end
