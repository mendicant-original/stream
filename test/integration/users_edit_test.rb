require 'test_helper'

class ArticlesEditTest < ActionDispatch::IntegrationTest

  test "edit myself" do
    user = Factory(:john)
    sign_user_in(user)
    visit users_path
    edit_user(user)
  end

  test "edit another user" do
    user = Factory(:john)
    other = Factory(:mary)
    sign_user_in(user)

    visit edit_user_path(other)
    fill_in "Name", :with => "Not Mary!"
    click_button "Save"

    assert_current_path users_path
    within '#alert' do
      assert_content "Permission denied"
    end
  end

  test "edit another user as admin" do
    admin = Factory(:admin)
    user = Factory(:john)

    sign_user_in(admin)
    visit users_path
    within user do
      click_link "Edit"
    end

    assert_current_path(edit_user_path(user))
    fill_in "Name", :with => "User#{user.id}"
    click_button "Save"

    assert_current_path user_path(user)
    within 'section' do
      assert_content "User#{user.id}"
    end
  end

  private

  def edit_user(user)
    within user do
      click_link("Edit")
    end
    assert_current_path edit_user_path(user)
    fill_in "Name", :with => "edited"
    click_button "Save"

    assert_current_path user_path(user)
    within "section" do
      assert_content("edited")
    end
  end
end