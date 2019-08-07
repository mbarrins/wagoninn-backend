class PetImmunisation < ApplicationRecord
  belongs_to :pet
  belongs_to :immunisation
  belongs_to :validity
  before_save :calculate_expiry

  def calculate_expiry
    expiry = self.effecitive_date
    if self.validity.duration == 'year'
      expiry = self.effecitive_date.next_year(self.validity.code)
    end
    self.expiry_date = expiry
  end
end
