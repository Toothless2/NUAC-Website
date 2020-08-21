class CreateSignups < ActiveRecord::Migration[6.0]
  def change
    create_table :signups do |t|
      t.boolean :enabled, default: true

      t.timestamps
    end
  end
end
