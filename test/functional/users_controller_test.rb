require 'test_helper'
class UserControllerTest < ActionController::TestCase

  setup do
    @controller = UsersController.new
  end

  test "cannot destroy another user" do
    user = Factory(:john)
    other = Factory(:mary)

    @controller.expects(:current_user).returns(user)
    User.expects(:find).returns(other)
    other.expects(:destroy).never()


    delete :destroy, {'id' => other.id}
    assert_redirected_to users_path
    assert_equal("Permission denied",flash[:alert])
  end
end