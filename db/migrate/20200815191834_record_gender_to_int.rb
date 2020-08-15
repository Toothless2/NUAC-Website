class RecordGenderToInt < ActiveRecord::Migration[6.0]
  def change
    change_column :records, :gender, :integer
  end
end
