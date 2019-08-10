class BookingPen < ApplicationRecord
  belongs_to :booking
  belongs_to :pen_type
  belongs_to :pen
end
