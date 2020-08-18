class ConvertGenderToString < ActiveRecord::Migration[6.0]
  def change
    change_column :records, :gender, :string
  end
end
