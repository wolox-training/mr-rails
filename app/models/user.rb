class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :validatable
  validates :first_name, :last_name, :locale, presence: true
  devise :database_authenticatable,
         :recoverable, :trackable, :validatable, :rememberable
  include DeviseTokenAuth::Concerns::User
  has_many :rents, dependent: :destroy
  has_many :book_suggestions, dependent: :destroy
end
