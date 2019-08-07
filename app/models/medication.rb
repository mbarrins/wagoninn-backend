class Medication < ApplicationRecord
  has_many :pet_medications
  delegate :medication, :to => :pet_medication
end
