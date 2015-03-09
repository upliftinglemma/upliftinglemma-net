##
# This class represents an app on the website.
#
# == Schema Information
#
# Table name: apps
#
#  id          :integer          not null, primary key
#  name        :string           not null
#  engine_name :string           not null
#  slug        :string           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  user_id     :integer          not null
#  license     :string
#

class App < ActiveRecord::Base
    extend FriendlyId

    has_paper_trail

    has_many :roles
    has_many :users, through: :roles

    friendly_id :name, use: :slugged

    validates_presence_of :name, :type, :slug


    def route_name
        "#{slug.underscore}_app"
    end


    ##
    # Look up the app's engine by the type (i.e., the namespace).

    def engine
        self.type.deconstantize.constantize::Engine
    end


    ##
    # Decide if this app is the default app.

    def default?
        slug == self.class.default_slug
    end


    def roles_for user
        roles.where(user: user)
    end


    ##
    # The slug of the default app.

    def self.default_slug
        'uplifting-lemma'
    end


    ##
    # Get the default app.

    def self.default
        App.friendly.find(default_slug)
    end
end
