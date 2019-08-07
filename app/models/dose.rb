class Dose < ApplicationRecord
  has_many :pet_medications
  delegate :dose, :to => :pet_medication
end
