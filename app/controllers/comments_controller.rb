class CommentsController < ApplicationController
    load_and_authorize_resource

    def create
        @comment.save!
        redirect_to send(@app.route_name).url_for(@comment.commentable)
    end

    def update
        @comment.save!
        redirect_to send(@app.route_name).url_for(@comment.commentable)
    end

    def destroy
        @comment.destroy!
        redirect_to send(@app.route_name).url_for(@comment.commentable)
    end

    private

    def comment_params
        params.require(:comment).permit(:commentable_id, :commentable_type, :comment)
    end
end

