class CreateRoles < ActiveRecord::Migration[6.0]
  def change
    create_table :roles do |t|
      t.string :name, uniqueness: true
      t.boolean :admin, default: false
      t.boolean :canPost, default: false
      t.boolean :canEvent, default: false
      t.boolean :canEditHeader, default: false

      t.timestamps
    end

    add_index :roles, :name

    add_reference :users, :role
    remove_column :users, :admin
  end
end
