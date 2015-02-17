class AppsController < ApplicationController
    before_filter :load_app

    def show
    end

    def not_found
    end

    private

    def load_app
        @app = App.friendly.find(request.subdomain)
    end
end
