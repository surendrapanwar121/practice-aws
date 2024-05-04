class User < ApplicationRecord
  belongs_to :account
  # belongs_to :role

  has_one :role

  after_create :set_default_role

  def set_default_role
    self.role ||= self.account.find_or_create_by(name: Role::ADMIN)
  end
end
