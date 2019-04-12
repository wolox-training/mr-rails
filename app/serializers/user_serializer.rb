class UserSerializer < ActiveModel::Serializer
  attributes :first_name, :last_name, :email, :password, :locale

  has_many :rents
end
