require 'test_helper'

class ApplicationHelperTest < ActionView::TestCase
  test "#md converts markdown format to html, wrapping text in paragraphs" do
    @output_buffer = md(%q[
      **Hello** _world_

      Features to complete:

      * Articles search
      * Profile view: [github](https://github.com) area
    ].squeeze(" "))

    assert_select "strong", "Hello"
    assert_select "em", "world"
    assert_select "p", "Hello world"
    assert_select "p", "Features to complete:"
    assert_select "ul li", "Articles search"
    assert_select "ul li", "Profile view: github area"
    assert_select "a[href=\"https://github.com\"]", "github"
  end

  test "#render_error_messages returns a container listing all error messages in the object" do
    object = Article.new
    object.valid?
    errors_count = object.errors.count

    @output_buffer = render_error_messages(object)
    assert_select "h2", "#{errors_count} errors prohibited this Article " \
      "from being saved:"
    assert_select "li", "#{object.errors.full_messages.first}"
  end

  test "#render_error_messages renders nothing when the given object has no errors" do
    object = Factory(:john_article)
    assert_nil render_error_messages(object)
  end

  test "#render_flash_messages renders a paragraph for each message in the flash hash" do
    flash[:notice] = "Welcome to RMU WebDev 2!"

    @output_buffer = render_flash_messages
    assert_select "p", "Welcome to RMU WebDev 2!"
  end

  test "#render_flash_messages is html safe" do
    flash[:notice] = "Welcome to RMU WebDev 2!"

    @output_buffer = render_flash_messages
    assert @output_buffer.html_safe?
  end

  test "#render_flash_messages renders nothing when no flash is set" do
    assert_blank render_flash_messages
  end
end
