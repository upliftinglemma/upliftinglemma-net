class App < ActiveRecord::Base
    extend FriendlyId

    has_paper_trail

    friendly_id :name, use: :slugged

    has_many :roles
    has_many :users, through: :roles

    validates_presence_of :name, :type, :slug
end
