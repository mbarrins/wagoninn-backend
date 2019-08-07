class PetMedication < ApplicationRecord
  belongs_to :pet
  belongs_to :medication
  belongs_to :dose
  belongs_to :schedule
end
