class ActuallyMigrateRecordCols < ActiveRecord::Migration[6.0]
  def change
    remove_column :records, :bowstyle
    remove_column :records, :round # have to add then remove to make heroku happy
    add_column :records, :bowstyle, :integer
    add_column :records, :round, :integer
  end
end
