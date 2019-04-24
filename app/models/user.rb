class User < ActiveRecord::Base
  devise :database_authenticatable, :recoverable, :rememberable, :validatable
  validates :first_name, :last_name, :locale, presence: true
  include DeviseTokenAuth::Concerns::User
  has_many :rents, dependent: :destroy
  has_many :book_suggestions, dependent: :destroy
end
