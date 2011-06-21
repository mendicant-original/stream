require 'test_helper'

class ArticleTest < ActiveRecord::TestCase
  test "is #editable_by? admin user" do
    article = Factory(:john_article)
    user    = Factory(:admin)

    assert article.editable_by?(user)
  end

  test "is #editable_by? article author" do
    article = Factory(:john_article)
    user    = article.author

    assert article.editable_by?(user)
  end

  test "is not #editable_by? other users" do
    article = Factory(:john_article)
    user    = Factory(:mary)

    assert !article.editable_by?(user)
  end
end
