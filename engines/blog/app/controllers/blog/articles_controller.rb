require_dependency "blog/application_controller"

module Blog
    class ArticlesController < ApplicationController
        def index
            page = params[:page] || 1
            offset = (page - 1) * per_page

            @articles = @app.articles.order(created_at: :desc).offset(offset).limit(per_page)
        end

        def new
            @article = Article.new
            require_role 'writer'
        end

        def create
            require_role 'writer'
            @article = @app.articles.create(article_params)
            redirect_to article_path(@article)
        end

        def show
            @article = @app.articles.friendly.find(params[:id])
        end

        def edit
            require_role 'writer'
            @article = @app.articles.friendly.find(params[:id])
        end

        def update
            require_role 'writer'
            @article = @app.articles.friendly.find(params[:id])
        end

        def destroy
            require_role 'writer'
            @article = @app.articles.friendly.find(params[:id])
        end

        private

        def article_params
            params.require(:article).permit(:title, :tagline, :body)
        end

        def per_page
            5
        end
    end
end

