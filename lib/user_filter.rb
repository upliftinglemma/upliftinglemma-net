class UserFilter
    def initialize user, app
        @user = user
        @app = app
    end

    def with_somebody
        yield @user if @user.present?
    end

    def with_nobody
        yield unless @user.present?
    end

    def with_role role
        with_somebody do |user|
            yield user if user.has_role_for role, @app
        end
    end

    def without_role role
        with_somebody do |user|
            yield user unless user.has_role_for role, @app
        end
    end
end

