class RemoveAuthorFromArticles < ActiveRecord::Migration
    def change
        remove_foreign_key :blog_articles, column: :author_id
        remove_reference :blog_articles, :author
    end
end
