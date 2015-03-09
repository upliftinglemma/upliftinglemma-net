class ActionDispatch::Routing::Mapper
    def mount_app app
        subdomain = if app.default? then '' else app.slug end

        constraints subdomain: subdomain do
            mount app.engine, at: '/', as: "#{app.slug.underscore}_app"
        end
    end
end

