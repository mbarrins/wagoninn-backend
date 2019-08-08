class OwnerPenPet < ApplicationRecord
  belongs_to :owner_pen
  belongs_to :pet
  belongs_to :rate
end
