class User < ApplicationRecord
  belongs_to :user_type
  has_secure_password

  validates :first_name, :last_name, :email, :username, presence: true
  validates :email, :username, uniqueness: true
  validates :password, length: { minimimum: 6, maximum: 20 }, allow_nil: true
end
