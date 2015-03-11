require_dependency "blog/application_controller"

module Blog
    class ArticlesController < ApplicationController
        load_and_authorize_resource

        def index
            @articles = @articles.page params[:page]
        end

        def new
        end

        def create
            @article.save!
            redirect_to article_path(@article)
        end

        def show
            @article = @app.articles.friendly.find params[:id]
            @comment = @article.comments.new
        end

        def edit
            require_role 'writer'
            @article = @app.articles.friendly.find params[:id]
        end

        def update
            @article.save!
            redirect_to article_path(@article)
        end

        def destroy
            @article.destroy!
            redirect_to article_index_path
        end

        private

        def article_params
            params.require(:article).permit(:title, :tagline, :body)
        end
    end
end

