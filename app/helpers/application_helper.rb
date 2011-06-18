module ApplicationHelper
  def render_flash_messages
    flash.map do |kind, message|
      content_tag :p, message, :id => kind
    end.join.html_safe
  end
end
