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
