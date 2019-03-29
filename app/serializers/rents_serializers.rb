class RentsSerializer < ActiveModel::Serializer
  atributes :start_date, :end_date
  belongs_to :user
  belongs_to :book
end
