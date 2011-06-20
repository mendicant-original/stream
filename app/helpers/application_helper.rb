module ApplicationHelper
  def render_error_messages(object)
    if object.errors.any?
      name    = object.class.model_name.human
      message = pluralize(object.errors.count, "error")
      message = "#{message} prohibited this #{name} from being saved:"
      errors  = object.errors.full_messages.map { |m| content_tag(:li, m) }

      content_tag(:div, :id => "error_explanation") do
        content_tag(:h2, message) << content_tag(:ul, errors.join.html_safe)
      end
    end
  end

  def render_flash_messages
    flash.map do |kind, message|
      content_tag :p, message, :id => kind
    end.join.html_safe
  end
end
