ENV["RAILS_ENV"] = "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'capybara/rails'
require 'support/integration'

class ActionDispatch::IntegrationTest
  include Capybara::DSL
  include Support::Integration

  setup do
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:github] = {
      'provider' => 'github',
      'uid' => '12345',
      'user_info' => { 'nickname' => 'flow user' }
    }
  end

  teardown { Capybara.reset_sessions! } 
end

