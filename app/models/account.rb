class Account < ApplicationRecord
  belongs_to :owner, class_name: 'User', optional: true
  has_many :users, dependent: :destroy
  has_many :roles, dependent: :destroy

  validates :name, presence: true, uniqueness: true, length: { maximum: 10 }
  validates :owner, presence: true, if: -> { owner_id_changed? }

  after_create :set_default_data

  scope :enabled, -> { where(status: 'active') }

  private
  def set_default_data
    Role.create_default_roles(self)
  end
end
