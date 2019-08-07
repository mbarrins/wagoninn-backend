class PetType < ApplicationRecord
  has_many :pets
  delegate :animal, :to => :pet
end
