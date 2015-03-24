class CommentDecorator < ApplicationDecorator
  include RendersMarkdown

  decorates_association :author

  delegate_all

  def author_name css_class: 'comment-author'
    helpers.content_tag :span, class: css_class do
      author.name
    end
  end

  def created_timestamp css_class: 'comment-time'
    helpers.content_tag :time, datetime: created_at, class: css_class do
      created_at.to_s :nice_ordinal
    end
  end

  def byline css_class: 'comment-byline'
    if commentable.respond_to? :author and commentable.author == author
      author_context = ' (Author)'
    end

    helpers.content_tag :div, class: css_class do
      "#{author_name}#{author_context} on #{created_timestamp}".html_safe
    end
  end

  def rendered_body
    render_markdown body
  end
end

