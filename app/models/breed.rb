class Breed < ApplicationRecord
  has_many :pets
  delegate :breed, :to => :pet
end
