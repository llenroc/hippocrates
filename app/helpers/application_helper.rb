module ApplicationHelper
  def error_messages_for(resource, display_header = true)
    if resource.errors.any?
      header = display_header ? content_tag(:b, 'Por favor corrige los siguiente errores:') : ''
      body = content_tag(:ul, resource.errors.full_messages.map { |message| content_tag(:li, message) }.join, {}, false)
      content_tag(:div, "#{header} #{body}".html_safe, class: "text-danger")
    end
  end
end
