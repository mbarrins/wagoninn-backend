class Booking < ApplicationRecord
  belongs_to :owner
  belongs_to :booking_status

  def create_booking_ref
    Digest::SHA1.hexdigest(self.id.to_s)[8..16]
  end
end
