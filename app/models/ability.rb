class Ability
    include CanCan::Ability

    def initialize user
        alias_action :index, :show, to: :read
        alias_action :new, :create, to: :post
        alias_action :edit, :update, :destroy, to: :modify

        can :access, App
        can :read, Comment

        if user.present?
            can :post, Comment
            can :modify, Comment do |comment|
                comment.author == user
            end
        end
    end
end

