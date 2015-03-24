module LoadsModel
  extend ActiveSupport::Concern

  module ClassMethods
    protected

    ##
    # Create a before-action filter to load a model object (or collection of
    # model objects) based on the current action, then ensure that the current
    # user is authorized to use it for that action.
    #
    def load_and_authorize_model model_name = nil, only: nil, **kwargs

      # If the model is not specified, get it from the name of the current
      # controller. We assume a controller like WidgetsController has a
      # corresponding model named Widget.
      model_name ||= controller_name.singularize
      model_name = model_name.to_s

      before_action only: only do |controller|
        controller.send :do_load_and_authorize_model, model_name, **kwargs
      end

      decorates_assigned model_name
      decorates_assigned model_name.pluralize
    end
  end

  private

  ##
  # Load a model object (or collection of model objects) based on the current
  # action, then ensure that the current user is authorized to use it for
  # that action.
  #
  def do_load_and_authorize_model model_name, class_name: nil, find_by: :id, scope: nil

    # If the class name is not specified, use the model name. Assume the class
    # is in the same namespace as the controller.
    if class_name.nil?
      module_name = controller_path.classify.deconstantize
      class_name = "#{module_name}::#{model_name.to_s.classify}"
    end

    model_class = class_name.constantize

    if action_name == 'index'
      # In this case, we're dealing with a collection. Load the collection and
      # store it into an instance variable.
      collection_variable = "@#{model_name.to_s.pluralize}"
      collection = policy_scope(model_class)
      instance_variable_set collection_variable, collection

    else
      # In this case, we're dealing with a single object.
      model_variable = "@#{model_name}"

      # Scopes can be given in a few ways. If no scope is passed (i.e., it's
      # nil), use the model's class. If a symbol is passed, treat it as a
      # method name to call on the model class. If a proc is passed, execute it
      # with model's class as its context.
      model_scope =
        case scope
        when nil then model_class
        when Symbol then model_class.send scope
        when Proc then model_class.instance_exec &scope
        else raise ArgumentError, 'Invalid scope'
        end

      # The actions that deal with new objects need to create their object
      # here. All other actions load the object by a key (specified by the
      # find_by parameter).
      model =
        if %w(create new).include? action_name
          model_scope.new
        else
          model_scope.find params[find_by]
        end

      # The modification actions need to assign attributes on the model object.
      # We need to figure out which attributes to assign.
      if %w(create update).include? action_name
        params_method = "#{model_name}_params"

        safe_params =
          if respond_to? params_method
            # If the controller implements <model>_params explicitly, then use
            # it.
            send params_method
          else
            # Otherwise, get the permitted fields from the policy.
            permitted = policy(model).permitted_attributes
            params.require(model_name).permit *permitted
          end

        # Do the assignment
        model.assign_attributes safe_params
      end

      # Now that the model is all set (finally!) we can authorize it and store
      # it into an instance variable.
      authorize model
      instance_variable_set model_variable, model
    end
  end

end

