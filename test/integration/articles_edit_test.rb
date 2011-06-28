require 'test_helper'

class ArticlesEditTest < ActionDispatch::IntegrationTest
  test "edit an article I own" do
    article = Factory(:john_article)
    sign_user_in(article.author)
    edit_article(article)
  end

  test "attempt to edit an article with invalid attributes" do
    article = Factory(:john_article)
    sign_user_in(article.author)

    within article do
      assert_content "Rails 3 is coming!"

      click_link "edit"
    end

    fill_in "Title", :with => ""
    fill_in "Url", :with => "test@example.com"
    click_button "Post"

    assert_current_path article_path(article)
    assert_no_content "Article was successfully updated."
    assert_field "Title", :with => ""
    assert_field "Url", :with => "test@example.com"
    assert_content "2 errors prohibited this Article from being saved"
    assert_content "Title can't be blank"
    assert_content "Url is invalid"
  end

  test "attempt to edit an article when not signed in" do
    article = Factory(:john_article)

    visit root_path
    assert_no_link "edit"

    visit edit_article_path(article)
    assert_current_path "/auth/github"
  end

  test "attempt to edit an article from another user" do
    other_user_article = Factory(:mary_article)
    sign_user_in Factory(:john)

    within other_user_article do
      assert_content "Java rocks!"
      assert_no_link "edit"
    end

    visit edit_article_path(other_user_article)
    assert_current_path root_path
    assert_content "You are not authorized to edit other user's articles!"
  end

  test "as Admin - edit an article" do
    article = Factory(:john_article)
    sign_admin_in
    edit_article(article)
  end

  private

  def edit_article(article)
    within article do
      assert_content "Rails 3 is coming!"

      click_link "edit"
    end

    assert_current_path edit_article_path(article)
    assert_css "h2", :text => "Edit article"

    fill_in "Title", :with => "Rails 3 released"
    fill_in "Url", :with => "http://weblog.rubyonrails.org/rails-3-released"
    fill_in "Body", :with => "Rails 3 was released yesterday! Yay!"
    fill_in "Tags", :with => "ruby, rails, new release"
    click_button "Post"

    assert_current_path root_path
    assert_content "Article was successfully updated."
    within article do
      assert_link "Rails 3 released",
        :href => "http://weblog.rubyonrails.org/rails-3-released"
      assert_content "Rails 3 was released yesterday! Yay!"
      assert_no_content "Rails 3 is coming"
    end
  end
end
