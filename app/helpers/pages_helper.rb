module PagesHelper

  def editable_content(tag, id, default="", options={})
    contents = @page.contents || {}
    value = (contents[id] || default).html_safe ##TODO clean the html somewhere
    options[:id] = id
    css_class = options[:class] || ""
    options[:class] = css_class + " editable"
    content_tag(tag, value, options)
  end
  
end
