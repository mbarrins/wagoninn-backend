class Owner < ApplicationRecord
  has_many :pets
  has_many :owner_concerns
end
