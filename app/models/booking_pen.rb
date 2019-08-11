class BookingPen < ApplicationRecord
  belongs_to :booking
  belongs_to :pen_type
  belongs_to :pen, optional: true
  belongs_to :rate
  has_many :booking_pen_pets
end
