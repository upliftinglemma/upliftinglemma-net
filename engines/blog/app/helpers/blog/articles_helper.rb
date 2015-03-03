module Blog
    module ArticlesHelper

        def author article=nil
            article ||= @article
            ::User.find_by(id: article.originator.to_i)
        end

        def author_name article=nil
            user = author article

            if user.nil?
                'Unknown'
            else
                user.name
            end
        end

        def article_body article=nil
            article ||= @article
            markdown.render(article.body).html_safe
        end


        def article_byline article=nil
            article ||= @article
            "By #{author_name article} on #{article.created_at.to_s :long_ordinal}"
        end

        private

        def markdown
            renderer = ::Redcarpet::Render::HTML.new(
                filter_html: true, no_styles: true, safe_links_only: true, with_toc_data: true
            )

            ::Redcarpet::Markdown.new(
                renderer, autolink: true, strikethrough: true, underline: true, footnotes: true
            )
        end

    end
end
