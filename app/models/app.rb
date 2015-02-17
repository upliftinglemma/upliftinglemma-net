class App < ActiveRecord::Base
    has_paper_trail

    has_many :roles
    has_many :users, through: :roles
end
