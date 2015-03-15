class CommentPolicy < ApplicationPolicy
    def create?
        user.present? and policy(record.commentable).show?
    end

    def update?
        create? and record.author == user
    end

    def delete?
        update? or
            record.commentable.responds_to? :author and
            record.commentable.author == user
    end
end

