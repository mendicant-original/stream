module Support
  module Auth
    
    def mock_auth_for(auth)
      OmniAuth.config.mock_auth[:github] = {
        'provider' => auth.provider,
        'uid' => auth.uid,
        'user_info' => { 'name' => auth.user.name,
                         'nickname' => auth.user.github, 
                         'email' => auth.user.email
                       }
      }
    end
    
    def sign_user_in(user=Factory(:user))
      mock_auth_for(user.authorizations.first)
      visit '/auth/github'   # TODO should be click_link 'Sign In' ?
    end

    def sign_admin_in(admin=Factory(:admin))
      sign_user_in(admin)
    end

    def sign_out
      click_link 'Sign Out'
    end

  end
end
