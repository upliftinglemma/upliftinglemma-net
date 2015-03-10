class Comment < ActiveRecord::Base
    include Posted

    belongs_to :commentable, polymorphic: true
end

