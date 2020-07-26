class ActuallyMigrateRecordCols < ActiveRecord::Migration[6.0]
  def change
    change_column :records, :bowstyle, :interger
    change_column :records, :round, :interger
  end
end
