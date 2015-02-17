class CreateApps < ActiveRecord::Migration
    def change
        create_table :apps do |t|
            t.string :name, null: false
            t.string :type, null: false
            t.string :slug, null: false

            t.timestamps null: false
        end

        add_index :apps, :slug, unique: true
    end
end
