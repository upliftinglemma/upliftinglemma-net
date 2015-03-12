module CommentsHelper

    def comment_author comment, css_class: 'comment-author'
        content_tag :span, class: css_class do
            comment.author.name
        end
    end

    def comment_time comment, css_class: 'comment-time'
        content_tag :time, datetime: comment.created_at.to_s, class: css_class do
            comment.created_at.to_s :nice_ordinal
        end
    end

end

