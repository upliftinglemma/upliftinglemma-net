module CommentsHelper

    def comment_author_name comment
        user = comment.author

        if user.nil?
            'Unknown'
        else
            user.name
        end
    end

end

