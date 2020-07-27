class AllowNullUserOnRecord < ActiveRecord::Migration[6.0]
  def change
    change_column :record_names, :user_id, :user, :null => true
  end
end
