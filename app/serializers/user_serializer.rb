class UserSerializer < ActiveModel::Serializer
  attributes :first_name, :last_name, :email, :password

  has_many :rents
end
