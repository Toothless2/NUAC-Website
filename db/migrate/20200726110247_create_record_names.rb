class CreateRecordNames < ActiveRecord::Migration[6.0]
  def change
    create_table :record_names do |t|
      t.references :user, null: true, foreign_key: true
      t.string :name

      t.timestamps
    end
  end
end
