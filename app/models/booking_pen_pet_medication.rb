class BookingPenPetMedication < ApplicationRecord
  belongs_to :booking_pen_pet
  belongs_to :medication
  belongs_to :dose
  belongs_to :schedule
end
