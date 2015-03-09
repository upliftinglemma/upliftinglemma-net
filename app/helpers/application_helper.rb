module ApplicationHelper
    def app_route app=nil
        app = get_app app

        route = send app.route_name.to_sym
        subdomain = if app.default? then false else app.slug end

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



    def toolbar_item *args, **kwargs, &block
        content_tag :li do
            link_to *args, **kwargs, &block
        end
    end

    def toolbar_text content = nil, &block
        content_tag :li do
            content_tag :p, content, class: 'navbar-text', &block
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
