ENV["RAILS_ENV"] = "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'capybara/rails'

class ActionDispatch::IntegrationTest
  include Capybara::DSL

  def sign_user_in(user=users(:john))
    # Sign in stub method.
    visit root_path
    user
  end

  def sign_admin_in(admin=users(:admin))
    sign_user_in(admin)
  end

  def within(scope)
    scope = '#' << ActionController::RecordIdentifier.dom_id(scope) if scope.is_a?(ActiveRecord::Base)
    super
  end
end

class ActiveSupport::TestCase
  fixtures :all
end
