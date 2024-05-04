class CreateRoles < ActiveRecord::Migration[6.1]
  def change
    create_table :roles do |t|
      t.string :name
      t.boolean :admin
      t.boolean :portal
      t.string :description
      t.references :account, null: false, foreign_key: true

      t.timestamps
    end
  end
end
