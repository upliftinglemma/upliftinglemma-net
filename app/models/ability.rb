class Ability
  include CanCan::Ability

  def initialize user, app
    alias_action :index, :show, to: :read
    alias_action :new, :create, to: :post
    alias_action :edit, :update, :destroy, to: :modify

    can :access, App
    can :read, Comment

    if user.present?
      can :post, Comment do |comment|
        can? :read, comment.commentable
      end

      can :modify, Comment do |comment|
        can? :read, comment.commentable and
          comment.author == user
      end
    end
  end
end

