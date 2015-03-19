class ApplicationPolicy
  attr_reader :app_user, :model
  delegate :app, :user, to: :app_user

  def initialize app_user, model
    @app_user = app_user
    @model = model
  end

  def policy model
    Pundit.policy! app_user, model
  end

  def policy_scope model_class
    Pundit.policy_scope app_user, model_class
  end


  # Authorizations

  def show?
    scope.exists? model.id
  end

  def create?
    false
  end

  def new?
    create?
  end

  def update?
    false
  end

  def edit?
    update?
  end

  def destroy?
    false
  end


  # Application-specific

  def owner?
    false
  end

  def permitted_attributes
    []
  end


  # Scopes

  def scope
    Pundit.policy_scope! app_user, model.class
  end

  class Scope
    attr_reader :app_user, :scope
    delegate :app, :user, to: :app_user

    def initialize app_user, scope
      @app_user = app_user
      @scope = scope
    end

    def resolve
      scope
    end
  end
end

