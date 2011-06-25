require 'test_helper'

class UserTest < ActiveRecord::TestCase
  test "is editable_by? admin" do
    target = Factory(:john)
    admin = Factory(:admin)
    assert target.editable_by? admin
  end

  test "not editable_by? another user" do
    target = Factory(:john)
    user = Factory(:mary)
    assert_false target.editable_by? user
  end

  test "is editable_by? themselves" do
    target = Factory(:john)
    assert target.editable_by? target
  end

  test "admin cannot be mass assigned" do
    target = User.new(:name => 'foo', :admin => true)
    assert_false target.admin?
  end
end