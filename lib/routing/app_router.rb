module Routing
    class RootRouteAdaptor < SimpleDelegator
        # If a router tries to draw a route with root, just use get because a
        # route through a subdomain can't be the root.
        def root(*args, **kwargs)
            get '/', *args, **kwargs
        end
    end

    class AppRouter
        def self.get_router(app)
            "Routing::#{app.type}Router".constantize.new(app)
        end

        def self.route_all
            App.all.each do |app|
                # Save the router and the block in variables so we can use them
                # after our context gets changed.
                router = get_router(app)
                block = router.app_routes

                Rails.application.routes.draw do
                    if app.is_default?
                        # If this is the default app, just let it do it's
                        # thing.
                        constraints subdomain: '' do
                            instance_eval &block
                        end
                    else
                        # If this is not the default app, we need to restrict
                        # it to a subdomain and force it not to draw a root
                        # path.
                        constraints subdomain: app.slug do
                            obj = RootRouteAdaptor.new self
                            obj.instance_eval &block
                        end
                    end
                end
            end

            # Redirect any other subdomains to the default app
            Rails.application.routes.draw do
                constraints subdomain: /.+/ do
                    match ':any', to: redirect(subdomain: false, path: '/'), via: :all, any: /.*/
                end
            end
        end

        def initialize(app)
            @app = app
        end

        def app_routes
            Proc.new do
            end
        end

        def action(action)
            "#{@app.type.underscore}##{action}"
        end
    end
end

