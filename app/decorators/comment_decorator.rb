class CommentDecorator < ApplicationDecorator
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

    private

    def markdown
        renderer = ::Redcarpet::Render::HTML.new(
            filter_html: true, no_styles: true, safe_links_only: true, with_toc_data: true
        )

        ::Redcarpet::Markdown.new(
            renderer, autolink: true, strikethrough: true, underline: true
        )
    end
end

