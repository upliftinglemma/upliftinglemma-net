class AppsController < ApplicationController
    before_filter :load_app

    def show
    end

    private

    def load_app
        begin
            @app = App.friendly.find(request.subdomain)
        rescue ActiveRecord::RecordNotFound
            @app = App.default
        end
    end
end
