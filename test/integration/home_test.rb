require 'test_helper'

class HomeTest < ActionDispatch::IntegrationTest
  test "view formatted article body using Markdown" do
    article = Factory(:john_article, :body => "Rails 3 **rocks!**")

    visit root_path

    within article do
      assert_link "Rails 3"
      assert_content "Rails 3 rocks!"
      assert_css "strong", :text => "rocks!"
    end
  end
end
