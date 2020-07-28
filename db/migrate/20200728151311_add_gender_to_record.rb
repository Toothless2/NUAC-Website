class AddGenderToRecord < ActiveRecord::Migration[6.0]
  def change
    add_column :records, :gender, :boolean
  end
end
