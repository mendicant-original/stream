# Change div to span when generating fields with errors.
ActionView::Base.field_error_proc = Proc.new do |html_tag, instance|
  "<span class=\"field_with_errors\">#{html_tag}</span>".html_safe
end
