class CreateApps < ActiveRecord::Migration
  def change
    create_table :apps do |t|
      t.string :name
      t.string :theme
      t.string :type

      t.timestamps null: false
    end
  end
end
