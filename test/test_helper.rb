ENV["RAILS_ENV"] = "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'capybara/rails'

class ActionDispatch::IntegrationTest
  include Capybara::DSL

  # TODO: remove when integrating entire auth.
  teardown { ApplicationController.current_user_signed_in = nil }

  # TODO: Stub current user using Omniauth and remove ApplicationController hack.
  def sign_user_in(user=Factory(:user))
    ApplicationController.current_user_signed_in = user
    visit root_path
    user
  end

  def sign_admin_in(admin=Factory(:admin))
    sign_user_in(admin)
  end

  def within(scope)
    scope = '#' << ActionController::RecordIdentifier.dom_id(scope) if scope.is_a?(ActiveRecord::Base)
    super
  end
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
