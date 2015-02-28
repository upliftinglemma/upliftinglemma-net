class RenameAppsEngineToEngineName < ActiveRecord::Migration
    def change
        change_table :apps do |t|
            t.rename :engine, :engine_name
        end
    end
end
