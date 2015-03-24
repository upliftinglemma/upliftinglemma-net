module Blog
  class ArticleDecorator < ::ApplicationDecorator
    include ::RendersMarkdown

    decorates_association :comments
    decorates_association :author
    decorates_association :previous
    decorates_association :next

    delegate_all

    def author_name css_class: 'article-author'
      helpers.content_tag :span, class: css_class do
        if author.nil?
          'Unknown'
        else
          author.name
        end
      end
    end

    def created_timestamp css_class: 'article-time'
      helpers.content_tag :time, datetime: created_at, class: css_class do
        created_at.to_s :nice_ordinal
      end
    end

    def byline css_class: 'article-byline'
      helpers.content_tag :p, class: css_class do
        "By #{author_name} on #{created_timestamp}".html_safe
      end
    end

    def rendered_body
      render_markdown body
    end

    def rendered_summary length: 500
      helpers.truncate_html rendered_body, length: length,
        omission: ' &hellip;'.html_safe
    end
  end
end

