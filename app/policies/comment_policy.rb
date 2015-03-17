class CommentPolicy < ApplicationPolicy
    def create?
        user.present? and policy(model.commentable).show?
    end

    def update?
        create? and owner?
    end

    def destroy?
        update? or policy(model.commentable).owner?
    end


    def owner?
        user.present? and model.author == user
    end

    def permitted_attributes
        [:commentable_id, :commentable_type, :body]
    end
end

