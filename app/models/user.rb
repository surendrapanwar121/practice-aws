class User < ApplicationRecord
  belongs_to :account
  belongs_to :role
  # has_one :role

  has_secure_password :password, validations: true
  validates_uniqueness_of :email, case_sensitive: false, scope: :account_id
  validates :name, presence: true, uniqueness: true, length: { maximum: 50 }

  after_create :set_default_role

  scope :all_users, -> { where(deleted: false) }
  scope :enabled, -> { where(disabled: false) }
  scope :disabled, -> { where(disabled: true) }

  def set_default_role
    self.role ||= self.account.find_or_create_by(name: Role::REQUESTER)
  end
end
