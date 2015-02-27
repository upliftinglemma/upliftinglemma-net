module ApplicationHelper
    def content_or_default_for(name, default=nil)
        if content_for?(name)
            content_for(name)
        else
            default
        end
    end

    def app_url
        if @app.is_default?
            root_url subdomain: false
        else
            root_url subdomain: @app.slug
        end
    end

    def app_theme
        "themes/#{@app.slug}"
    end
end
