class ActuallyMigrateRecordCols < ActiveRecord::Migration[6.0]
  def change
    change_column :records, :bowstyle, :integer
    change_column :records, :round, :integer
  end
end
