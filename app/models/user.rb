class User < ApplicationRecord
  belongs_to :user_type
  has_secure_password
  belongs_to :person, :polymorphic => true

  validates :username, presence: true
  validates :username, uniqueness: true
  validates :password, length: { minimimum: 6, maximum: 20 }, allow_nil: true
end
