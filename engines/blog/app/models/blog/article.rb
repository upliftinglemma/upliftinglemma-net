module Blog
    class Article < ActiveRecord::Base
        include ::Commentable
        include ::FriendlyId
        include ::Posted

        belongs_to :blog

        friendly_id :slug_candidates, use: :scoped, scope: :blog

        validates_presence_of :title, :slug, :blog, :body
        validate :blog_is_a_blog


        private

        ##
        # Validates that the app we're calling a blog is, in fact, a blog.

        def blog_is_a_blog
            blog.is_a? Blog
        end


        ##
        # A list of possible attributes to incude in the slug. One of these
        # should almost certainly be chosen, unless a user somehow posts two
        # articles with the same title at the exact same time.

        def slug_candidates
            [
                :title,
                [:title, :created_at]
            ]
        end
    end
end

