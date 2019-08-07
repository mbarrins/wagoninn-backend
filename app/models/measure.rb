class Measure < ApplicationRecord
  has_many :pet_foods
  delegate :measure, :to => :pet_food
end
