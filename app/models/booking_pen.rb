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
    todays_pens = BookingPen.all.select{|pen| pen.booking.booking_status != 'Cancelled' && pen.booking.check_in <= Date.parse(date) && (pen.booking.check_out > Date.parse(date) || (pen.booking.check_out >= Date.parse(date) && pen.booking.booking_status.name == 'Active'))}

    PenType.all.map do |type|
      if type.name === 'Dog Run'
        [type.name.gsub(/\s+/, ""), todays_pens.select{|pen| pen.pen_type_id == type.id && pen.pen_id}.map do |pen|
          [pen.pen_id, pen.booking_pen_detail]
        end.to_h]
      else 
        [type.name.gsub(/\s+/, ""), todays_pens.select{|pen| pen.pen_type_id == type.id}.map do |pen|
          pen.booking_pen_detail
        end]
      end
    end.to_h

  end

  def booking_pen_detail
    {
      id: self.booking.id,
      check_in: self.booking.check_in,
      check_in_time: self.booking.check_in_time,
      check_out: self.booking.check_out,
      check_out_time: self.booking.check_out_time,
      owner_id: self.booking.owner.id,
      owner_name: self.booking.owner.name,
      status: self.booking.booking_status.name,
      pen: self.pen ? self.pen.name : '',
      pen_no: self.pen ? self.pen.no : '',
      pet_listing: self.booking_pen_pets.map{|pet| pet.pet.name}.to_sentence,
      pens: self.booking.booking_pens.sort_by{|pen| pen.id}.map{|pen| {
        id: pen.id,
        pen_id: pen.pen_id ? pen.pen_id : '',
        pen_type: pen.pen_type.name, 
        pet_type: pen.pen_type.pet_type.name, 
        pets: pen.booking_pen_pets.sort_by{|pet| pet.id}.map{|pet| pet.pet.name}.to_sentence,
        pets_detail: pen.booking_pen_pets.sort{|pet| pet.id}.map{|pet| pet.pet.pet_type.name == 'Dog' ? {
          id: pet.pet.id, 
          name: pet.pet.name, 
          breed: pet.pet.breed.name,
          size: pet.pet.size.name
        } : {
          id: pet.pet.id, 
          name: pet.pet.name, 
          color: pet.pet.color.name, 
          size: pet.pet.size.name
        }}
      }},
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

  def self.available_pens(check_in:, check_out:, pen_type_id:)
    BookingPen.available_all(check_in: check_in, check_out: check_out, pen_type_id: pen_type_id).map{|pen_id| Pen.find(pen_id)}
  end

  def self.booked_pens(date:, pen_type_id:)
    check_in = check_in.class == String ? Date.parse(check_in) : check_in
    check_out = check_out.class == String ? Date.parse(check_out) : check_out

    BookingPen.all.select{|pen| pen.pen_type_id == pen_type_id && pen.booking.check_in <= Date.parse(date) && pen.booking.check_out > Date.parse(date)}.map{|pen| pen.pen_id}
  end

  def self.booked_pens_all(check_in:, check_out:, pen_type_id:)
    check_in = check_in.class == String ? Date.parse(check_in) : check_in
    check_out = check_out.class == String ? Date.parse(check_out) : check_out
      
    booked = BookingPen.all.select{|pen| pen.pen_type_id == pen_type_id && pen.booking.check_in <= check_out && pen.booking.check_out > check_in && pen.pen_id}.map{|pen| pen.pen_id}

    booked.uniq
  end

  def self.bookings_by_date(date_from:, date_to:)

    pens = BookingPen.pens_by_date(date_from: date_from, date_to: date_to)

    range = (Date.parse(date_from)..Date.parse(date_to)).to_a

    range.map do |date| 
      {
        date: date, 
        day_of_week: date.strftime('%w').to_i,
        pens: PenType.all.map do |type|
          booked = pens.select{|pen| pen[:pen_type_id] == type.id && pen[:check_in] <= date && pen[:check_out] > date}.length
          no_pets = pens.select{|pen| pen[:pen_type_id] == type.id && pen[:check_in] <= date && pen[:check_out] > date}.map{|pen| pen[:pets]}.reduce(:+) || 0

          if type.always_show || pens.select{|pen| pen[:pen_type_id] == type.id && pen[:check_in] <= date && pen[:check_out] > date}.length > 0
            {
              pen_type_id: type.id,
              pen_type: type.name,
              pet_type: PetType.find(type[:pet_type_id]).name,
              booked: booked,
              no_pets: no_pets,
              no_pens: type.no_pens,
              available: type.no_pens - (type.name == 'Cat Room' ? no_pets : booked)
            }
          end
        end.compact}
    end
  end
end
