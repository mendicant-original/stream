require 'test_helper'

class ArticleTest < ActiveRecord::TestCase
  setup do
    @article = Factory(:john_article)
  end

  test "is #editable_by? admin user" do
    assert @article.editable_by?(Factory(:admin))
  end

  test "is #editable_by? article author" do
    assert @article.editable_by?(@article.author)
  end

  test "is not #editable_by? other users" do
    assert !@article.editable_by?(Factory(:mary))
  end

  test "is not #editable_by? anyone when not persisted" do
    assert !Article.new.editable_by?(@article.author)
  end

  test "#tag_list returns a list of the tags joined by ," do
    @article.tags = %w(ruby rails webdev).map { |tag| Tag.new(:name => tag) }

    assert_equal "ruby, rails, webdev", @article.tag_list
  end

  test "#tag_list is empty when there are no tags set" do
    assert_blank @article.tag_list
  end

  test "#tag_list= creates tags based on the given list" do
    assert_equal 0, Tag.count

    @article.tag_list = "ruby, rails, webdev"
    assert @article.save

    tags = Tag.all
    assert_equal 3, tags.count
    assert_equal %w(ruby rails webdev), tags.collect(&:name)
  end

  test "#tag_list= reuses tags with the same name and does not create new ones" do
    %w(ruby webdev).each { |tag| Tag.create(:name => tag) }
    assert_equal 2, Tag.count

    @article.tag_list = "ruby, rails, webdev"
    assert @article.save

    tags = Tag.all
    assert_equal 3, tags.count
    assert_equal %w(ruby webdev rails), tags.collect(&:name)
  end

  test "#tag_list= strips whitespaces and ignores blank values" do
    @article.tag_list = "ruby,  ,  rails  , webdev"
    assert @article.save

    assert_equal "ruby,  ,  rails  , webdev", @article.tag_list
    assert_equal "ruby, rails, webdev", Article.find(@article).tag_list

    tags = Tag.all
    assert_equal 3, tags.count
    assert_equal %w(ruby rails webdev), tags.collect(&:name)
  end

  test "#tag_list= deletes unused taggings" do
    @article.tag_list = "ruby, rails, webdev"
    assert @article.save

    assert_equal 3, Tag.count
    assert_equal 3, @article.reload.taggings.count

    @article.tag_list = "ruby, webdev"
    assert @article.save

    assert_equal 3, Tag.count
    assert_equal 2, @article.reload.taggings.count
  end
end
