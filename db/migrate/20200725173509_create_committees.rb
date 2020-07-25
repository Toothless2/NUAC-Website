class CreateCommittees < ActiveRecord::Migration[6.0]
  def change
    create_table :committees do |t|
      t.string :name
      t.string :role
      t.string :description

      t.timestamps
    end
  end
end
