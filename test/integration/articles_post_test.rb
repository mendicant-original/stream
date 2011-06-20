require 'test_helper'

class ArticlesPostTest < ActionDispatch::IntegrationTest
  test "post a new article" do
    sign_user_in
    click_link "Post article"

    assert_current_path new_article_path
    assert_css "h1", :text => "Post an article"

    fill_in "Title", :with => "Rails 3 released"
    fill_in "Url", :with => "http://weblog.rubyonrails.org/rails-3-released"
    fill_in "Body", :with => "Rails 3 was released yesterday! Yay!"
    fill_in "Tags", :with => "ruby, rails, new release"
    click_button "Post"

    assert_current_path root_path
    assert_content "Article was successfully created."
    assert_link "Rails 3 released",
                :href => "http://weblog.rubyonrails.org/rails-3-released"
    assert_content "Rails 3 was released yesterday! Yay!"
  end

  test "attempt to post an article with invalid attributes" do
    sign_user_in
    click_link "Post article"

    fill_in "Title", :with => "R3"
    fill_in "Url", :with => "test@example.com"
    click_button "Post"

    assert_current_path articles_path
    assert_no_content "Article was successfully created."
    assert_field "Title", :with => "R3"
    assert_field "Url", :with => "test@example.com"
    assert_content "3 errors prohibited this Article from being saved"
    assert_content "Title is too short (minimum is 3 characters"
    assert_content "Url is invalid"
    assert_content "Body can't be blank"
  end

  test "attempt to post an article when not signed in" do
    visit root_path
    assert_no_link "Post article"

    visit new_article_path
    assert_current_path sign_in_path
    assert_content "Please sign in to continue!"
  end
end
