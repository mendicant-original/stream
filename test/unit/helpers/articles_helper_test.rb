require 'test_helper'

class ArticlesHelperTest < ActionView::TestCase
  test "url host returns the host for the given url" do
    assert_equal 'google.com', url_host('http://google.com/search')
    assert_equal 'university.rubymendicant.com',
      url_host('http://university.rubymendicant.com/changelog.html')
  end
end
