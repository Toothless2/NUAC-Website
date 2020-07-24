class CreatePageContents < ActiveRecord::Migration[6.0]
  def change
    create_table :page_contents do |t|
      t.string :page, uniqueness: true
      t.string :body
      t.timestamps
    end

    add_index :page_contents, :page
  end
end
