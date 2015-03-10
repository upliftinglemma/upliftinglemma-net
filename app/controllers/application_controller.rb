class ApplicationController < ActionController::Base
    include BrowserID::Rails::Base

    # Prevent CSRF attacks by raising an exception.
    # For APIs, you may want to use :null_session instead.
    protect_from_forgery with: :exception

    before_filter :load_app

    helper_method :authenticated?, :current_user

    alias_method :authenticated?, :browserid_authenticated?
    alias_method :current_user, :browserid_current_user


    private


    # Allow engines to define their own abilities for CanCan.
    def current_ability
        namespace = self.class.name.deconstantize
        ability_class = "#{namespace}::Ability".constantize

        ability_class.new current_user
    end

    # Determine which app we are currently running based on the subdomain, and
    # make sure we are authorized to access it.
    def load_app
        if request.subdomain.blank?
            @app = App.default
        else
            @app = App.friendly.find request.subdomain
        end

        authorize! :access, @app
    end
end

