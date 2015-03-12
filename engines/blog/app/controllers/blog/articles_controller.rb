require_dependency "blog/application_controller"

module Blog
    class ArticlesController < ApplicationController
        include HasComments

        load_and_authorize_resource find_by: :slug

        def index
            @articles = @articles.page params[:page]
        end

        def new
        end

        def create
            if @article.save
                redirect_to article_path(@article)
            else
                render :new
            end
        end

        def show
            load_comments
        end

        def edit
        end

        def update
            if @article.save
                redirect_to article_path(@article)
            else
                render :edit
            end
        end

        def destroy
            if @article.destroy
                redirect_to article_index_path
            else
                render :show
            end
        end

        private

        def article_params
            params.require(:article).permit(:title, :tagline, :body)
        end
    end
end

