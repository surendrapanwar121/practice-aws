class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :email
      t.string :first_name
      t.string :last_name
      t.string :password_digest
      t.string :password_confirmation
      t.string :activation_code
      t.datetime :activated_at
      t.boolean :deleted
      t.boolean :disabled
      t.references :account, null: false, foreign_key: true
      t.references :role, null: false, foreign_key: true

      t.timestamps
    end
  end
end
