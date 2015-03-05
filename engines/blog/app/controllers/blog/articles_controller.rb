require_dependency "blog/application_controller"

module Blog
    class ArticlesController < ApplicationController
        def index
            @articles = @app.articles.order(created_at: :desc).take 5
        end

        def new
        end

        def create
            @article = @app.articles.create(article_params)
            redirect_to article_path(@article)
        end

        def show
            @article = @app.articles.friendly.find(params[:id])
        end

        def edit
        end

        def update
        end

        def destroy
        end

        private

        def article_params
            params.require(:article).permit(:title, :tagline, :body)
        end
    end
end

