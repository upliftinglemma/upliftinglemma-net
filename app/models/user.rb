class User < ActiveRecord::Base
    has_many :roles
    has_many :apps, through: :roles
end
