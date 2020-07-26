class AddTagToPost < ActiveRecord::Migration[6.0]
  def change
    add_column :posts, :tag, :string
  end
end
