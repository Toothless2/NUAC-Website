class NonNullPosts < ActiveRecord::Migration[6.0]
  def change
    change_column :posts, :title, :string, null: false
    change_column :posts, :body, :string, null: false
  end
end
