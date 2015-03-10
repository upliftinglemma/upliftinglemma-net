module Blog
    class Ability < ::Ability
        def initialize user
            super

            can :read, Article

            if user.present?
                can :post, Article do |article|
                    user.has_role_for 'writer', article.blog
                end

                can :modify, Article do |article|
                    user.has_role_for 'writer', article.blog
                    article.author = user
                end
            end
        end
    end
end

