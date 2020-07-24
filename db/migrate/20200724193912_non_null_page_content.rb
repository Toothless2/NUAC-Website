class NonNullPageContent < ActiveRecord::Migration[6.0]
  def change
    change_column :page_contents, :page, :string, null: false
    change_column :page_contents, :body, :string, null: false
  end
end
