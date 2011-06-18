require 'test_helper'

class ArticlesPostTest < ActionDispatch::IntegrationTest
  test "post a new article" do
    sign_user_in
    click_link "Post article"

    assert_equal new_article_path, current_path
    assert has_css?("h1", "Post an article")

    fill_in "Title", :with => "Rails 3 released"
    fill_in "Url", :with => "http://weblog.rubyonrails.org/rails-3-released"
    fill_in "Body", :with => "Rails 3 was released yesterday! Yay!"
    fill_in "Tags", :with => "ruby, rails, new release"
    click_button "Post"

    assert_equal root_path, current_path
    assert has_content?("Article was successfully created.")
    assert has_link?("Rails 3 released",
                     :href => "http://weblog.rubyonrails.org/rails-3-released")
    assert has_content?("Rails 3 was released yesterday! Yay!")
  end

  test "attempt to post an article with invalid attributes" do
    sign_user_in
    click_link "Post article"

    fill_in "Title", :with => "R3"
    fill_in "Url", :with => "test@example.com"
    click_button "Post"

    assert_equal articles_path, current_path
    assert has_no_content?("Article was successfully created.")
    assert has_field?("Title", :with => "R3")
    assert has_field?("Url", :with => "test@example.com")
    assert has_content?("3 errors prohibited this article from being saved")
    assert has_content?("Title is too short (minimum is 3 characters)")
    assert has_content?("Url is invalid")
    assert has_content?("Body can't be blank")
  end

  test "attempt to post an article when not signed in" do
    # TODO: remove after integrating authentication
    User.delete_all

    visit root_path
    assert has_no_link?("Post article")

    visit new_article_path
    assert_equal sign_in_path, current_path
    assert has_content?("Please sign in to continue!")
  end
end
