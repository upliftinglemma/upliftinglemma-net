class ChangeAppTypeToEngine < ActiveRecord::Migration
    def change
        change_table :apps do |t|
            t.rename :type, :engine
        end
    end
end
