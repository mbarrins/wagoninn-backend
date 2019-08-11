class Booking < ApplicationRecord
  belongs_to :owner
  belongs_to :booking_status
  has_many :booking_pens
  after_create :set_booking_ref

  def self.create_with_all(booking:, booking_pens:)
    booking = Booking.find_or_create_by(booking)

    if booking.valid?
      booking_pens.each do |pen|
        booking_pen = BookingPen.find_or_create_by({
          booking: booking,
          pen_type_id: pen.pen_type_id,
          pen_id: pen.pen_id,
          rate_id: pen.rate_id
        })

        pen.booking_pen_pets.each do |pet|
          BookingPenPet.find_or_create_by({
            booking_pen: booking_pen,
            pet_id: pet.pet_id,
            special_needs_fee: pet.special_needs_fee
          })
        end
      end
    end

    booking
  end

  private

  def set_booking_ref
    self.booking_ref = Digest::SHA1.hexdigest(self.id.to_s)[8..16]
    self.save
  end
end
