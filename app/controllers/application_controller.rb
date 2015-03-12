class ApplicationController < ActionController::Base
    include BrowserID::Rails::Base

    # Prevent CSRF attacks by raising an exception.
    # For APIs, you may want to use :null_session instead.
    protect_from_forgery with: :exception

    before_filter :load_app

    helper_method :authenticated?, :current_user, :app_route, :get_app

    alias_method :authenticated?, :browserid_authenticated?
    alias_method :current_user, :browserid_current_user


    def app_route app=nil
        app = get_app app

        route = send app.route_name
        subdomain = if app.default? then false else app.slug end

        EngineRouteModifier.new route, subdomain: subdomain
    end


    def get_app app
        if app.nil?
            @app
        elsif app.is_a? String or app.is_a? Symbol
            App.friendly.find app.to_s
        else
            app
        end
    end


    private


    ##
    # Allow engines to define their own abilities for CanCan.
    #
    def current_ability
        namespace = @app.type.deconstantize
        ability_class = "#{namespace}::Ability".constantize

        ability_class.new current_user, @app
    end


    ##
    # Determine which app we are currently running based on the subdomain, and
    # make sure we are authorized to access it.
    #
    def load_app
        if request.subdomain.blank?
            @app = App.default
        else
            @app = App.friendly.find request.subdomain
        end

        authorize! :access, @app
    end
end

