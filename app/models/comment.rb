class Comment < ActiveRecord::Base
    include Posted

    belongs_to :commentable, polymorphic: true

    validates_presence_of :comment
end

