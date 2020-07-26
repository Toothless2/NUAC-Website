class CreateRecords < ActiveRecord::Migration[6.0]
  def change
    create_table :records do |t|
      t.references :record_name, null: false, foreign_key: true
      t.integer :score
      t.string :round
      t.string :bowstyle
      t.date :achived_at
      t.string :location
      t.string :other_round

      t.timestamps
    end
    add_index :records, :round
    add_index :records, :bowstyle
    add_index :records, :achived_at
    add_index :records, :location
  end
end
