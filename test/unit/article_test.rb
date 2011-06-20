require 'test_helper'

class ArticleTest < ActiveRecord::TestCase
  test "is #editable_by? admin user" do
    article = articles(:john_article)
    user    = users(:admin)

    assert article.editable_by?(user)
  end

  test "is #editable_by? article author" do
    article = articles(:john_article)
    user    = users(:john)

    assert article.editable_by?(user)
  end

  test "is not #editable_by? other users" do
    article = articles(:john_article)
    user    = users(:mary)

    assert !article.editable_by?(user)
  end
end
