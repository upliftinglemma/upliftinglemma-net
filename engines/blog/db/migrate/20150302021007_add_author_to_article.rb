class AddAuthorToArticle < ActiveRecord::Migration
    def change
        add_reference :blog_articles, :author, index: true, null: false, references: :users
        add_foreign_key :blog_articles, :users, column: :author_id
    end
end
