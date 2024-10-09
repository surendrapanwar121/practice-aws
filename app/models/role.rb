class Role < ApplicationRecord
  SERVICE_AGENT_USER = 'Service Agent User'
  ADMIN = 'Administrator'
  REQUESTER = 'Requester'
  ALL_ROLES = [ADMIN, SERVICE_AGENT_USER, REQUESTER]

  belongs_to :account
  has_many :users

  scope :admin, -> { find_by(name: ADMIN) }

  def self.create_default_roles(account)
    Role::ALL_ROLES.each do |role|
      account.roles << account.roles.find_or_create_by(name: role)
    end
  end
end
