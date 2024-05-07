class Role < ApplicationRecord
  SERVICE_AGENT_USER = 'Service Agent User'
  ADMIN = 'Administrator'
  REQUESTER = 'Requester'
  ALL_ROLES = [ADMIN, SERVICE_AGENT_USER, REQUESTER]

  belongs_to :account
  has_many :users

  scope :admin, -> { find_by(name: ADMIN) }
end
