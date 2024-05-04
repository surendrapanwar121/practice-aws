class AddOwnerToAccounts < ActiveRecord::Migration[6.1]
  def change
    add_reference :accounts, :owner, foreign_key: { to_table: :users }
  end
end
