class User < ActiveRecord::Base
  validates :first_name, :last_name, presence: true
  devise :database_authenticatable, :registerable,
         :recoverable, :trackable, :validatable, :rememberable
  include DeviseTokenAuth::Concerns::User
end
