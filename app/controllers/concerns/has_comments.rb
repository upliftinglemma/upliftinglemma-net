module HasComments
  extend ActiveSupport::Concern

  module ClassMethods
    protected

    ##
    # Create a before-action filter to load a model object (or collection of
    # model objects) based on the current action, then ensure that the current
    # user is authorized to use it for that action.
    #
    def load_and_authorize_comments *args, only: nil

      # If the model is not specified, get it from the name of the current
      # controller. We assume a controller like WidgetsController has a
      # corresponding model named Widget.
      model_name ||= controller_name.singularize
      model_name = model_name.to_s

      before_action only: only do |controller|
        controller.send :do_load_and_authorize_comments, *args
      end

      decorates_assigned "#{model_name}_new_comment"
      decorates_assigned "#{model_name}_comments"
    end
  end

  private

  ##
  # Load a model object (or collection of model objects) based on the current
  # action, then ensure that the current user is authorized to use it for
  # that action.
  #
  def do_load_and_authorize_comments model_name = nil

    # If the model is not specified, get it from the name of the current
    # controller. We assume a controller like WidgetsController has a
    # corresponding model named Widget.
    model_name ||= controller_name.singularize

    # We load the model from its instance variable
    model_variable = "@#{model_name}"

    # If that instance variable is not set, bail. This action doesn't have that
    # model available (or may have a collection).
    if not instance_variable_defined? model_variable
      return
    end

    # Load the model
    model = instance_variable_get model_variable

    # Create a new comment for the form and stick it in an instance variable.
    new_comment_variable = "@#{model_name}_new_comment"
    new_comment = model.comments.new
    instance_variable_set new_comment_variable, new_comment

    # Find the comments for this model. Only take the ones that have an id so
    # we don't get the new one we just made.
    comments_variable = "@#{model_name}_comments"
    comments = model.comments.where.not id: nil
    instance_variable_set comments_variable, comments
  end
end

