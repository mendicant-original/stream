ENV["RAILS_ENV"] = "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'capybara/rails'
require 'support/integration'

class ActionDispatch::IntegrationTest
  include Capybara::DSL
  include Support::Integration

  # TODO: remove when integrating entire auth.
  teardown { ApplicationController.current_user_signed_in = nil }
end

# TODO: hack for setting current user, remove when integrating entire auth.
class ApplicationController < ActionController::Base
  @@current_user_signed_in = nil

  def self.current_user_signed_in=(user)
    @@current_user_signed_in = user
  end

  def current_user
    @@current_user_signed_in
  end
end
