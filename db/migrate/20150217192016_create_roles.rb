class CreateRoles < ActiveRecord::Migration
  def change
    create_table :roles do |t|
      t.integer :app_id
      t.integer :user_id
      t.string :role

      t.timestamps null: false
    end
  end
end
