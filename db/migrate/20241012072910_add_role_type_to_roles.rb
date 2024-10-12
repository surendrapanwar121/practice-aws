class AddRoleTypeToRoles < ActiveRecord::Migration[6.1]
  def change
    remove_column :roles, :admin, :boolean
    remove_column :roles, :portal, :boolean

    add_column :roles, :role_type, :integer, null: false, default: 2
  end
end
