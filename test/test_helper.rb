ENV["RAILS_ENV"] = "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'test_notifier/runner/test_unit'
require 'capybara/rails'
require 'support/integration'
require 'support/auth'

class ActionDispatch::IntegrationTest
  include Capybara::DSL
  include Support::Integration
  include Support::Auth

  setup  { OmniAuth.config.test_mode = true }

  teardown { Capybara.reset_sessions! }
end

