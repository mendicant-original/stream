require 'mocha'

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
    
    def mock_uniweb(hash)
      RestClient::Resource.any_instance.stubs(:get).returns(
        [ hash ].to_json
      )
    end
    
    def uniweb_hash_student
      {'github' => 'dummy', 'alumnus' => false, 'staff' => false}
    end

    def uniweb_hash_alumnus
      {'github' => 'dummy', 'alumnus' => true, 'staff' => false}
    end
    
    def uniweb_hash_staff
      {'github' => 'dummy', 'alumnus' => false, 'staff' => true}
    end
    
    def uniweb_hash_error
      {'error' => 'github handle not found'}
    end
    
    def sign_user_in(user=Factory(:user), uniweb_hash=uniweb_hash_alumnus)
      mock_auth_for(user.authorizations.first)
      mock_uniweb(uniweb_hash)
      visit '/auth/github'   # TODO should be click_link 'Sign In' ?
    end

    def sign_admin_in(admin=Factory(:admin), uniweb_hash=uniweb_hash_staff)
      sign_user_in(admin, uniweb_hash)
    end

    def sign_out
      click_link 'Sign Out'
    end

  end
end
