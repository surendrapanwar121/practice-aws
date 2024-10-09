class AddDetailsToAccount < ActiveRecord::Migration[6.1]
  def change
    add_column :accounts, :type, :string
    add_column :accounts, :sector, :string
    add_column :accounts, :organization_id, :integer
    add_foreign_key :accounts, :accounts, column: :organization_id
  end
end
