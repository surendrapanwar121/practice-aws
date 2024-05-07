class Account < ApplicationRecord
  belongs_to :owner, class_name: 'User', optional: true
  has_many :users, dependent: :destroy
  has_many :roles, dependent: :destroy

  validates :name, uniqueness: true
  validates :name, length: { maximum: 10 }
  validates :owner, presence: true, if: -> { owner_id_changed? }

  after_create :set_default_data

  scope :enabled, -> { where(status: 'active') }

  private
  def set_default_data
    create_default_roles
  end

  def create_default_roles
    Role::ALL_ROLES.each do |role|
      roles << Role.find_or_create_by(name: role)
    end
  end
end
