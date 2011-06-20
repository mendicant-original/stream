require 'test_helper'

class ArticlesDestroyTest < ActionDispatch::IntegrationTest
  test "destroy an article I own" do
    article = Factory(:john_article)
    sign_user_in(article.author)
    destroy_article(article)
  end

  test "attempt to destroy an article when not signed in" do
    article = Factory(:john_article)

    visit root_path
    assert has_no_link?("destroy")
  end

  test "attempt to destroy an article from another user" do
    other_user_article = Factory(:mary_article)
    sign_user_in Factory(:john)

    within other_user_article do
      assert has_content?("Java rocks!")
      assert has_no_link?("destroy")
    end
  end

  test "as Admin - destroy an article" do
    article = Factory(:john_article)
    sign_admin_in
    destroy_article(article)
  end

  private

  def destroy_article(article)
    assert has_css?(".article", :count => 1)
    within article do
      assert has_content?("Rails 3 is coming!")

      click_link "destroy"
    end

    assert_equal root_path, current_path
    assert has_content?("Article was successfully destroyed.")
    assert has_no_content?("Rails 3 is coming!")
    assert has_no_css?(".article")
  end
end
