module Blog
    class Ability < ::Ability
        def initialize user, app
            super

            can :read, Article

            if user.present?
                can :post, Article do |article|
                    user.has_role_for 'writer', app
                end

                can :modify, Article do |article|
                    user.has_role_for 'writer', article.blog and
                        article.blog == app and
                        article.author == user
                end
            end
        end
    end
end

