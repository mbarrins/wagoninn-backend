class Booking < ApplicationRecord
  belongs_to :owner
  belongs_to :booking_status
  has_many :booking_pens
  after_create :set_booking_ref


  private

  def set_booking_ref
    self.booking_ref = Digest::SHA1.hexdigest(self.id.to_s)[8..16]
    self.save
  end
end
