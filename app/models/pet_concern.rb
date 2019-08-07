class PetConcern < ApplicationRecord
  belongs_to :pet
  belongs_to :concerns
end
