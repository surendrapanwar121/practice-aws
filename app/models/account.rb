class Account < ApplicationRecord
  before_create :create_default_roles

  belongs_to :owner, class_name: 'User'
  has_many :users, dependent: :destroy
  has_many :roles, dependent: :destroy

  def create_default_roles
    ##role creattion like adminstrator, requester, service agent user, service task user
  end
end
