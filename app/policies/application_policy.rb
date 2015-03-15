class ApplicationPolicy
    attr_reader :app_user, :record
    delegate :app, :user, to: :app_user

    def initialize app_user, record
        @app_user = app_user
        @record = record
    end

    def policy record
        Pundit.policy! app_user, record
    end


    # Authorizations

    def index?
        false
    end

    def show?
        scope.where(:id => record.id).exists?
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


    # Scopes

    def scope
        Pundit.policy_scope! app_user, record.class
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

