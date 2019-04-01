class RentSerializer < ActiveModel::Serializer
  attributes :start_date, :end_date
  belongs_to :user
  belongs_to :book
end
