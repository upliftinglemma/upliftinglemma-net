class UserUseLogin < ActiveRecord::Migration
    def change
        add_reference :users, :primary_login, index: true, references: :logins
        add_foreign_key :users, :logins, column: :primary_login_id
    end
end
