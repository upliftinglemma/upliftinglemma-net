# == Schema Information
#
# Table name: apps
#
#  id         :integer          not null, primary key
#  name       :string           not null
#  engine     :string           not null
#  slug       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer          not null
#  license    :string
#

class App < ActiveRecord::Base
    extend FriendlyId

    has_paper_trail

    friendly_id :name, use: :slugged

    has_many :roles

    belongs_to :user

    validates_presence_of :name, :engine_name, :slug

    def engine
        engine_name.constantize::Engine
    end

    def engine=(engine)
        self.engine_name = engine.name.deconstantize
    end

    def is_default?
        slug == self.class.default_slug
    end

    def self.default_slug
        'uplifting-lemma'
    end

    def self.default
        App.friendly.find(default_slug)
    end
end
