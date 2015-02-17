class CreateRoles < ActiveRecord::Migration
    def change
        create_table :roles do |t|
            t.integer :app_id, null: false
            t.integer :user_id, null: false
            t.string :role, null: false

            t.timestamps null: false
        end
    end
end
