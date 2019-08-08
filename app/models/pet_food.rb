class PetFood < ApplicationRecord
  belongs_to :pet
  belongs_to :food
  belongs_to :schedule
  belongs_to :measure

  # delegate :measure, :to => :measure
  # delegate :food, :to => :food
end
