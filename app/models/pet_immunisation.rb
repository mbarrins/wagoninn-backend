class PetImmunisation < ApplicationRecord
  belongs_to :pet
  belongs_to :immunisation
  belongs_to :validity

end
