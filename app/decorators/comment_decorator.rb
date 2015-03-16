class CommentDecorator < ApplicationDecorator
    delegate_all

    def author_name css_class: 'comment-author'
        content_tag :span, class: css_class do
            model.author.name
        end
    end

    def created_timestamp css_class: 'comment-time'
        content_tag :time, datetime: model.created_at.to_s, class: css_class do
            model.created_at.to_s :nice_ordinal
        end
    end

end
