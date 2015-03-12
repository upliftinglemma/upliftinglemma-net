module Blog
    class App < ::App
        has_many :articles, foreign_key: 'blog_id'
    end
end

