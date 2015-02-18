module AppsHelper

    def app_url
        if @app.is_default?
            root_url subdomain: false
        else
            root_url subdomain: @app.slug
        end
    end

end
