module Blog
    class ArticlePolicy < ::ApplicationPolicy
        def index?
            true
        end

        def show?
            true
        end

        def create?
            user.present? and
                user.has_role_for 'writer', app
        end

        def update?
            create? and record.blog == app and record.author == user
        end

        def destroy?
            update?
        end
    end
end

