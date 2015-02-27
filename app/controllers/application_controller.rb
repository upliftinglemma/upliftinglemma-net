class ApplicationController < ActionController::Base
    include BrowserID::Rails::Base

    # Prevent CSRF attacks by raising an exception.
    # For APIs, you may want to use :null_session instead.
    protect_from_forgery with: :exception

    alias_method :authenticated?, :browserid_authenticated?
    alias_method :current_user, :browserid_current_user

    before_filter :load_app

    private

    # Determine which app we are currently running based on the subdomain.
    def load_app
        begin
            @app = App.friendly.find(request.subdomain)
        rescue ActiveRecord::RecordNotFound
            @app = App.default
        end
    end
end
