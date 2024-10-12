class Role < ApplicationRecord
  SERVICE_AGENT_USER = 'Service Agent User'
  ADMIN = 'Administrator'
  REQUESTER = 'Requester'
  ALL_ROLES = [ADMIN, SERVICE_AGENT_USER, REQUESTER]

  enum role_type: {
    administrator: 0,
    service_agent_user: 1,
    requester: 2
  }

  belongs_to :account
  has_many :users

  validates :name, presence: true, uniqueness: { case_sensitive: false, scope: :account_id }

  def self.create_default_roles(account)
    ALL_ROLES.each_with_index do |role, index|
      account.roles.find_or_create_by(name: role, role_type: index)
    end
  end
end
