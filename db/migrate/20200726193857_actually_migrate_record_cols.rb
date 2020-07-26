class ActuallyMigrateRecordCols < ActiveRecord::Migration[6.0]
  def change
    delete_column :records, :bowstyle
    delete_column :records, :round
    change_column :records, :bowstyle, :integer
    change_column :records, :round, :integer
  end
end
