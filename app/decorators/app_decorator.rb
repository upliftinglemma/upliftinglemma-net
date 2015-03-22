class AppDecorator < ApplicationDecorator
  include RendersMarkdown

  delegate_all

  def rendered_description
    render_markdown "**#{name}** #{description}"
  end
end

