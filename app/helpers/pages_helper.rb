module PagesHelper

  def editable_content(tag, id, default="", options={})
    contents = @page.contents || {}
    value = (contents[id] || default).html_safe ##TODO clean the html somewhere
    options[:id] = id
    css_class = options[:class] || ""
    options[:class] = css_class + " editable"
    content_tag(tag, value, options)
  end
  
  def meta_title
    (@page.meta_title || (current_site.title + " - " + @page.title)).html_safe
  end
  
  def meta_desc
    (@page.meta_desc || (@page.title + " for " + current_site.title)).html_safe
  end
  
  def meta_author
    (@page.meta_author || (current_user.email)).html_safe
  end
  
end
