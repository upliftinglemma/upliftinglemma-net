class ApplicationController < ActionController::Base
    include BrowserID::Rails::Base
    include Pundit

    # Prevent CSRF attacks by raising an exception.
    # For APIs, you may want to use :null_session instead.
    protect_from_forgery with: :exception

    helper_method :authenticated?, :current_user, :app_route, :get_app

    alias_method :authenticated?, :browserid_authenticated?
    alias_method :current_user, :browserid_current_user

    before_action :load_and_authorize_app


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


    ##
    # Create a before-action filter to load a model object (or collection of
    # model objects) based on the current action, then ensure that the current
    # user is authorized to use it for that action.
    #
    def self.load_and_authorize_model model_name=nil, scope: nil, class_name: nil
        before_action do |controller|
            model_name ||= controller.controller_name.singularize

            # If the class name is not specified, use the model name. Assume
            # the class is in the same namespace as the controller.
            if class_name.nil?
                module_name = controller.controller_path.classify.deconstantize
                class_name = "#{module_name}::#{model_name.classify}"
            end

            model_class = class_name.constantize

            if controller.action_name == 'index'
                # In this case, we're dealing with a collection.
                collection_variable = "@#{model_name.to_s.pluralize}"
                collection = controller.policy_scope(model_class)
                controller.instance_variable_set collection_variable, collection

            else
                # In this case, we're dealing with a single object.
                model_variable = "@#{model_name}"

                model_scope =
                    case scope
                    when nil then model_class
                    when Symbol then model_class.send scope
                    when Proc then model_class.instance_exec &scope
                    else raise ArgumentError, 'Invalid scope'
                    end

                model =
                    case controller.action_name
                    when 'create', 'new' then model_scope.new
                    else model_scope.find params[:id]
                    end

                case controller.action_name
                when 'create', 'update'
                    params_method = "#{model_name}_params"
                    safe_params = controller.send params_method
                    model.assign_attributes safe_params
                end

                controller.authorize model
                controller.instance_variable_set model_variable, model
            end
        end
    end


    private


    ##
    # Determine which app we are currently running based on the subdomain, and
    # make sure we are authorized to access it.
    #
    def load_and_authorize_app
        if request.subdomain.blank?
            @app = App.default
        else
            @app = App.friendly.find request.subdomain
        end

        authorize @app, :access?
    end


    ##
    # Override the user passed to pundit
    #
    def pundit_user
        AppUser.new @app, current_user
    end
end

