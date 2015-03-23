class AppDecorator < ApplicationDecorator
  include RendersMarkdown

  decorates_association :owner

  delegate_all

  def class_name
    "app-#{slug}"
  end

  def class_for prop
    %W(#{class_name} theme-#{prop})
  end

  def rendered_description
    render_markdown "**#{name}** #{description}"
  end

  def stylesheet
    "themes/#{slug}"
  end
end

