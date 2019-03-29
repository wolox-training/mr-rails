class UsersSenializer < ActiveModel::Serializer
  atributes :first_name, :last_name, :email, :password

  has_many :rents
end
