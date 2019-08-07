class HouseholdPenPet < ApplicationRecord
  belongs_to :household_pen
  belongs_to :pet
  belongs_to :rate
end
