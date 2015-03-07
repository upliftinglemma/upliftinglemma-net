class CreateLogins < ActiveRecord::Migration
    def change
        create_table :logins do |t|
            t.string :email, null: false
            t.references :user, index: true, null: false
            t.boolean :disabled, null: false, default: false
        end
        add_index :logins, :email, unique: true
        add_foreign_key :logins, :users
    end
end
