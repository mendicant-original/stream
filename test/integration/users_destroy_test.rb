require 'test_helper'

class UserDestroyTest < ActionDispatch::IntegrationTest

  test "destroy myself" do
    user = Factory :john
    sign_user_in(user)
    visit users_path

    within user do
      click_link 'Destroy'
    end

    assert_current_path users_path
    within '#notice' do
      assert_content 'successfully deleted'
    end

    assert_no_css "user_#{user.id}"
  end

  test "destroy other user" do
    user = Factory :john
    other = Factory :mary

    sign_user_in(user)

    visit users_path

    within other do
      assert_no_link('Destroy')
    end

    delete_via_redirect "/users/#{other.id}"

    within '#alert' do
      assert_content "Permission denied"
    end
  end

  test "destroy other user as admin" do
    user = Factory :john
    admin = Factory :admin

    sign_user_in(admin)

    visit users_path

    within user do
      click_link 'Destroy'
    end

    assert_current_path(users_path)
    within '#notice' do
      assert_content 'successfully deleted'
    end
    assert_no_css "user_#{user.id}"
  end
end