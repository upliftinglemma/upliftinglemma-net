module ApplicationHelper
    def app_route app=nil
        app = get_app(app)

        route = send app.route_name.to_sym
        subdomain = if app.is_default? then false else app.slug end

        ::EngineRouteModifier.new route, subdomain: subdomain
    end

    def app_theme app=nil
        app = get_app(app)
        "themes/#{app.slug}"
    end

    private

    def get_app app
        if app.nil? then
            @app
        elsif app.is_a? String then
            App.friendly.find(app)
        else
            app
        end
    end
end
