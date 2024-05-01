class ChangeDescriptionColumnInPosts < ActiveRecord::Migration[6.1]
  def change
    rename_column :posts, :description, :body
    change_column :posts, :body, :text
  end
end
