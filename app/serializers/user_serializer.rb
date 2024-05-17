class UserSerializer < ActiveModel::Serializer
  attributes :email, :name, :role

  def role
    object.role.name
  end
end
