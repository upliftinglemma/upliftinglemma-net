module Blog
    class ArticlesController < ApplicationController
        def index
        end

        def new
        end

        def create
            @article = @app.articles.create(article_params)
            redirect_to article_path(@article)
        end

        def show
            @article = @app.articles.friendly.find(params[:id])
            @author = ::User.find(@article.originator.to_i) unless @article.originator.nil?
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

