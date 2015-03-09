class ApplicationController < ActionController::Base
    include BrowserID::Rails::Base

    # Prevent CSRF attacks by raising an exception.
    # For APIs, you may want to use :null_session instead.
    protect_from_forgery with: :exception

    before_filter :load_app

    helper_method :authenticated?, :current_user, :for_user

    alias_method :authenticated?, :browserid_authenticated?
    alias_method :current_user, :browserid_current_user

    def for_user user=nil, app=nil
        user ||= current_user
        app ||= @app

        filter = UserFilter.new user, app
        yield filter

        nil
    end

    protected

    def require_role role
        for_user do |f|
            f.without_role role do |user|
                raise User::NotAuthorized
            end

            f.with_nobody do
                raise User::NotAuthorized
            end
        end
    end

    private

    # Determine which app we are currently running based on the subdomain.
    def load_app
        if request.subdomain.blank?
            @app = App.default
        else
            @app = App.friendly.find(request.subdomain)
        end
    end
end
