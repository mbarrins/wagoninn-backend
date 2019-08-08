class Booking < ApplicationRecord
  belongs_to :owner
  belongs_to :booking_status
end
