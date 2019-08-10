class BookingPenPet < ApplicationRecord
  belongs_to :booking
  belongs_to :pen_type
  belongs_to :pen
  belongs_to :pet
  belongs_to :rate
end
