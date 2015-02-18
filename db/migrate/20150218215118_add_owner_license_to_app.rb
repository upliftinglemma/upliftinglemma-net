class AddOwnerLicenseToApp < ActiveRecord::Migration
    def change
        add_reference :apps, :user, index: true
        change_column_null :apps, :user_id, false
        add_foreign_key :apps, :users
        add_column :apps, :license, :string
    end
end
