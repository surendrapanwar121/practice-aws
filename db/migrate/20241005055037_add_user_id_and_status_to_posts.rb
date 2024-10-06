class AddUserIdAndStatusToPosts < ActiveRecord::Migration[6.1]
  def change
    add_column :posts, :user_id, :integer
    add_column :posts, :status, :integer, default: 0, null: false
    add_index :posts, :user_id
    add_foreign_key :posts, :users
  end
end
