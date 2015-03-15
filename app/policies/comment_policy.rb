class CommentPolicy < ApplicationPolicy
    def create?
        user.present? and policy(record.commentable).show?
    end

    def update?
        create? and record.author == user
    end

    def delete?
        update?
    end
end

