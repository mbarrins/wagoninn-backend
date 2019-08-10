class BookingPenPet < ApplicationRecord
  belongs_to :booking_pen
  belongs_to :pet
  belongs_to :rate
end
