class User < ActiveRecord::Base
    has_paper_trail

    has_many :roles

    has_many :apps
end
