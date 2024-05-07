class CreateAccounts < ActiveRecord::Migration[6.1]
  def change
    create_table :accounts do |t|
      t.string :name
      t.text :description
      t.string :status
      t.string :country
      t.text :default_helpdek_url
      t.text :service_desk_name

      t.timestamps
    end
  end
end
