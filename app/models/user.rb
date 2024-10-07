class User < ApplicationRecord
  belongs_to :account
  belongs_to :role
  has_many :posts

  has_secure_password :password, validations: true
  validates_uniqueness_of :email, case_sensitive: false, scope: :account_id
  validates :name, presence: true, uniqueness: true, length: { maximum: 50 }

  after_create :set_default_role

  scope :all_users, -> { where(deleted: false) }
  scope :enabled, -> { where(disabled: false) }
  scope :disabled, -> { where(disabled: true) }

  acts_as_csv(:email, :name, :disabled,
   { attr_name: :deleted, value: Proc.new { |v| v ? 'Yes' : 'No' } },
   { attr_name: :role_id, new_attr_name: :Role, value: Proc.new { |role_id| find_name_by_id(Role, role_id) } },
   { attr_name: :account_id, new_attr_name: :Account, value: Proc.new { |account_id| Account.find_by(id: account_id).name } }
  )

  def set_default_role
    self.role ||= self.account.find_or_create_by(name: Role::REQUESTER)
  end
end
