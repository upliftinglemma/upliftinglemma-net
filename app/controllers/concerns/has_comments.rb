module HasComments
    extend ActiveSupport::Concern

    def load_comments with_new: true
        @commentable = instance_variable_get "@#{controller_name.singularize}"
        @comments = @commentable.comments.where.not id: nil

        if with_new
            @new_comment = @commentable.comments.new
        end
    end
end

