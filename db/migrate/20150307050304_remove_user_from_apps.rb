class RemoveUserFromApps < ActiveRecord::Migration
    def change
        remove_reference :apps, :user
    end
end
