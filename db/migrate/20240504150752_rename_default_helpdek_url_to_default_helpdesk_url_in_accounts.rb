class RenameDefaultHelpdekUrlToDefaultHelpdeskUrlInAccounts < ActiveRecord::Migration[6.0]
  def change
    rename_column :accounts, :default_helpdek_url, :default_helpdesk_url
  end
end
