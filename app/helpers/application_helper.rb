module ApplicationHelper
    def app_route app=nil
        app = get_app app

        route = send app.route_name.to_sym
        subdomain = if app.is_default? then false else app.slug end

        ::EngineRouteModifier.new route, subdomain: subdomain
    end

    def app_stylesheet app=nil
        app = get_app app
        "themes/#{app.slug}"
    end

    def app_class app=nil
        app = get_app app
        "app-#{app.slug}"
    end

    def app_class_for prop, app=nil
        %W(#{app_class app} theme-#{prop})
    end

    def app_short_name app=nil
        app = get_app app

        if app.is_default?
            "upliftinglemma"
        else
            "upliftinglemma-#{@app.slug}"
        end
    end

    private

    def get_app app
        if app.nil?
            @app
        elsif app.is_a? String
            App.friendly.find app
        else
            app
        end
    end
end
