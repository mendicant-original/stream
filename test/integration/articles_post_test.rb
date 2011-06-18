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
    assert has_content?("ruby, rails, new release")
  end

  protected

  def sign_user_in
    # Sign in stub method.
    visit root_path
  end
end
