class User < ActiveRecord::Base
  validates :first_name, :last_name, :locale, presence: true
  devise :database_authenticatable, :registerable,
         :recoverable, :trackable, :validatable, :rememberable
  include DeviseTokenAuth::Concerns::User
  has_many :rents, dependent: :destroy
  has_many :book_suggestions, dependent: :destroy
end
