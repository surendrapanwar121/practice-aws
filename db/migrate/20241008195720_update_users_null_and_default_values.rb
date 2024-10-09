class UpdateUsersNullAndDefaultValues < ActiveRecord::Migration[6.1]
  def change
    change_column_null :users, :account_id, true
    change_column_null :users, :role_id, true

    change_column_default :users, :deleted, from: nil, to: false
    change_column_default :users, :disabled, from: nil, to: false
  end
end
