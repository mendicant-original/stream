require 'test_helper'

class ArticlesDestroyTest < ActionDispatch::IntegrationTest
  test "destroy an article I own" do
    sign_user_in
    destroy_article
  end

  test "attempt to destroy an article when not signed in" do
    # TODO: remove after integrating authentication
    User.delete_all
    article = articles(:john_article)

    visit root_path
    assert has_no_link?("destroy")
  end

  test "attempt to destroy an article from another user" do
    sign_user_in users(:john)
    other_user_article = articles(:mary_article)

    within other_user_article do
      assert has_content?("Java rocks!")
      assert has_no_link?("destroy")
    end
  end

  test "as Admin - destroy an article" do
    # TODO: remove after auth integration. Need to have only the admin.
    User.delete_all(["id <> ?", users(:admin)])
    sign_admin_in
    destroy_article
  end

  private

  def destroy_article
    article = articles(:john_article)

    assert has_css?(".article", :count => 2)
    within article do
      assert has_content?("Rails 3 is coming!")

      click_link "destroy"
    end

    assert_equal root_path, current_path
    assert has_content?("Article was successfully destroyed.")
    assert has_no_content?("Rails 3 is coming!")
    assert has_css?(".article", :count => 1)
    assert has_css?("h1", "Edit article")
  end
end
