class User < ApplicationRecord
  belongs_to :account
  has_many :posts
  belongs_to :role, optional: true
  has_many :user_roles, dependent: :destroy
  has_many :roles, through: :user_roles

  has_secure_password :password, validations: true
  validates :email, presence: true, uniqueness: { case_sensitive: false, scope: :account_id }
  validates :name, presence: true, length: { maximum: 50 }

  scope :all_users, -> { where(deleted: false) }
  scope :enabled, -> { where(disabled: false) }
  scope :disabled, -> { where(disabled: true) }

  acts_as_csv(:email, :name, :disabled,
   { attr_name: :deleted, value: Proc.new { |v| v ? 'Yes' : 'No' } },
   { attr_name: :role_id, new_attr_name: :Role, value: Proc.new { |role_id| find_name_by_id(Role, role_id) } },
   { attr_name: :account_id, new_attr_name: :Account, value: Proc.new { |account_id| Account.find_by(id: account_id).name } }
  )

  def role
    if account.is_a?(LegacyAccount)
      super
    else
      roles.find_by(account_id: current_account.id)
    end
  end

  def role_id
    if account.is_a?(LegacyAccount)
      super
    else
      role.id
    end
  end
end
