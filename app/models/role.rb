class Role < ActiveRecord::Base
    has_paper_trail

    belongs_to :app
    belongs_to :user
end
