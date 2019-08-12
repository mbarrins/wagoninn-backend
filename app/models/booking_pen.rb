class BookingPen < ApplicationRecord
  belongs_to :booking
  belongs_to :pen_type
  belongs_to :pen, optional: true
  belongs_to :rate
  has_many :booking_pen_pets

  def self.pens_by_date(date_from:, date_to:)
    pens = BookingPen.select{|pen| pen.booking.check_in <= Date.parse(date_to) && pen.booking.check_out >= Date.parse(date_from)}

    pens.map do |pen| 
      {
        pen_type_id: pen.pen_type_id, 
        pen_type: pen.pen_type.name, 
        check_in: pen.booking.check_in, 
        check_out: pen.booking.check_out, 
        pets: pen.booking_pen_pets.length
      }
    end
  end

  def self.bookings_by_date(date_from:, date_to:)

    pens = BookingPen.pens_by_date(date_from: date_from, date_to: date_to)

    range = (Date.parse(date_from)..Date.parse(date_to)).to_a

    range.map do |date| 
      {date: date, day_of_week: date.strftime('%w').to_i, pens: PenType.all.map do |type|
        if type.always_show || pens.select{|pen| pen[:pen_type_id] == type.id && pen[:check_in] <= date && pen[:check_out] > date}.length > 0
          {
            pen_type: type.name,
            pet_type: PetType.find(type[:pet_type_id]).name,
            booked: pens.select{|pen| pen[:pen_type_id] == type.id && pen[:check_in] <= date && pen[:check_out] > date}.length,
            no_pets: pens.select{|pen| pen[:pen_type_id] == type.id && pen[:check_in] <= date && pen[:check_out] > date}.map{|pen| pen[:pets]}.reduce(:+) || 0,
            no_pens: type.no_pens
          }
        end
      end.compact}
    end
  end
end
