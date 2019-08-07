class Food < ApplicationRecord
  has_many :pet_foods
  delegate :food, :to => :pet_food
end
