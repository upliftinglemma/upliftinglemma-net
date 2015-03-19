class CommentsController < ApplicationController
  load_and_authorize_model

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
end

