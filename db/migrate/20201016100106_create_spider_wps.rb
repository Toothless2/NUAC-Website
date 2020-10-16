class CreateSpiderWps < ActiveRecord::Migration[6.0]
  def change
    create_table :spider_wps do |t|
      t.references :record_name, null: false, foreign_key: true
      t.integer :spider_count, default: 0
      t.integer :pecker_count, deafult: 0

      t.timestamps
    end

    add_index :spider_wps, :record_name
  end
end
