module ApplicationHelper
  def app_stylesheet app = nil
    app = get_app app
    "themes/#{app.slug}"
  end

  def app_class app = nil
    app = get_app app
    "app-#{app.slug}"
  end

  def app_class_for prop, app = nil
    %W(#{app_class app} theme-#{prop})
  end



  def toolbar_item *args, &block
    content_tag :li do
      link_to *args, &block
    end
  end

  def toolbar_text content = nil, &block
    content_tag :li do
      content_tag :p, content, class: 'navbar-text', &block
    end
  end
end
