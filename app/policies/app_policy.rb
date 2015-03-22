class AppPolicy < ApplicationPolicy
  def access?
    true
  end

  def markdown_options
    {
      renderer: {
        no_styles: true,
        safe_links_only: true,
        with_toc_data: true
      },
      autolink: true,
      strikethrough: true,
      underline: true,
      footnotes: true
    }
  end
end

