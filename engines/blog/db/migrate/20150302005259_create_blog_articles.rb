class CreateBlogArticles < ActiveRecord::Migration
    def change
        create_table :blog_articles do |t|
            t.string :title, null: false
            t.string :tagline
            t.string :slug, null: false
            t.references :blog, index: true, null: false, references: :apps
            t.text :body, null: false

            t.timestamps null: false
        end

        add_index :blog_articles, :slug, unique: true
        add_foreign_key :blog_articles, :apps, column: :blog_id
    end
end
