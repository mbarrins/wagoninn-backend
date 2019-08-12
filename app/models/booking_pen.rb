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

  def self.daily_detail(date:)
    todays_pens = BookingPen.all.select{|pen| pen.booking.check_in <= Date.parse(date) && pen.booking.check_out > Date.parse(date)}

    PenType.all.map do |type|
      [type.name, todays_pens.select{|pen| pen.pen_type_id == type.id}]
    end.to_h

  end

  def booking_pen_detail
    {
      id: self.booking.id,
      check_in: self.booking.check_in,
      check_in_time: self.booking.check_in_time,
      check_out: self.booking.check_out,
      check_out_time: self.booking.check_out_time,
      owner_name: self.booking.owner.name,
      pen: self.pen.name,
      pet_listing: self.booking_pen_pets.map{|pet| pet.pet.name}.to_sentence
    }
  end

  def self.available(date:, pen_type_id:)
    all_pens = Pen.all.select{|pen| pen.pen_type_id == pen_type_id}.map{|pen| pen.id}
    booked = BookingPen.booked_pens(date: date, pen_type_id: pen_type_id)

    available = all_pens - booked 
  end

  def self.available_all(check_in:, check_out:, pen_type_id:)
    all_pens = Pen.all.select{|pen| pen.pen_type_id == pen_type_id}.map{|pen| pen.id}
    booked = BookingPen.booked_pens_all(check_in: check_in, check_out: check_out, pen_type_id: pen_type_id)

    all_pens - booked 
  end

  def self.booked_pens(date:, pen_type_id:)
    BookingPen.all.select{|pen| pen.pen_type_id == pen_type_id && pen.booking.check_in <= Date.parse(date) && pen.booking.check_out > Date.parse(date)}.map{|pen| pen.pen_id}
  end

  def self.booked_pens_all(check_in:, check_out:, pen_type_id:)
    check_in = check_in.class == 'String' ? Date.parse(check_in) : check_in
    check_out = check_out.class == 'String' ? Date.parse(check_out) : check_out
    
    booked = BookingPen.all.select{|pen| pen.pen_type_id == pen_type_id && pen.booking.check_in <= check_out && pen.booking.check_out > check_in}.map{|pen| pen.pen_id}
    empty_pens = booked.reduce(0){|sum, pen| pen == nil ? sum + 1 : sum}

    booked.uniq
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
