class Booking < ApplicationRecord
  belongs_to :household
  belongs_to :booking_status
end
