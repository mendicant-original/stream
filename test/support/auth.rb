module Support
  module Auth
    
    def mock_auth_for(user)
      OmniAuth.config.mock_auth[:github] = {
        'provider' => 'github',
        'uid' => '12345',
        'user_info' => { 'name' => user.name,
                         'nickname' => user.github, 
                         'email' => user.email
                       }
      }
    end
    
    def sign_user_in(user=Factory(:user))
      mock_auth_for(user)
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
