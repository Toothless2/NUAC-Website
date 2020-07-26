class ActuallyMigrateRecordCols < ActiveRecord::Migration[6.0]
  def change
    remove_column :records, :bowstyle
    remove_column :records, :round
    change_column :records, :bowstyle, :integer
    change_column :records, :round, :integer
  end
end
