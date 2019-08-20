class Booking < ApplicationRecord
  belongs_to :owner
  belongs_to :booking_status
  has_many :booking_pens
  after_create :set_booking_ref

  def self.income_by_date(date:)
    date_bookings = Booking.select{|booking| booking.check_in <= date && (booking.check_out > date || (booking.check_out == date && booking.check_out_time == 'PM'))}
    date_bookings.map{|booking| booking.booking_pens}.flatten.map{|pen| pen.rate.amount.to_f}.reduce(:+) || 0
  end

  def self.income_by_month(month:, year:)
    date_from = Date.parse("#{year}-#{month}-01")
    date_to = Date.parse("#{month.to_i == 12 ? (year.to_i + 1).to_s : year}-#{month.to_i == 12 ? 1 : month.to_i + 1}-01")-1

    Booking.select{|booking| booking.check_in <= date_to && booking.check_out >= date_from}.map{|booking| booking.fees_in_period(date_from: date_from, date_to: date_to)}.reduce(:+)
  end

  def self.year_income_by_month(year:)
    months = ("#{year}-01-01".to_date.."#{year}-12-31".to_date).map(&:beginning_of_month).uniq
    months.map{|month| {month: month.strftime('%B'), amount: Booking.income_by_month(month: month.strftime('%m'), year: year)}}
  end

  def daily_fee
    self.booking_pens.map{|pen| pen.rate.amount.to_f}.reduce(:+)
  end

  def duration
    (self.check_out - self.check_in).to_i + (self.check_out_time == 'PM' ? 1 : 0)
  end

  def days_in_period(date_from:, date_to:)
    date_from = date_from.class == String ? Date.parse(date_from) : date_from
    date_to = date_to.class == String ? Date.parse(date_to) : date_to

    days = self.duration
    days -= self.check_in < date_from ? (date_from - self.check_in).to_i : 0
    days -= self.check_out > date_to ? ((self.check_out_time == 'PM' ? self.check_out : (self.check_out - 1)) - date_to).to_i : 0
  end

  def fees_in_period(date_from:, date_to:)
    self.days_in_period(date_from: date_from, date_to: date_to) * self.daily_fee
  end

  def self.create_with_all(booking:, booking_pens:)

    booking = Booking.find_or_create_by(booking)
    
    if booking.valid?
      booking_pens.each do |pen|
        booking_pen = BookingPen.find_or_create_by({
          booking: booking,
          pen_type_id: pen['pen_type_id'],
          pen_id: pen['pen_id'],
          rate_id: pen['rate_id']
        })

        pen['booking_pen_pets'].each do |pet|
          BookingPenPet.find_or_create_by({
            booking_pen: booking_pen,
            pet_id: pet['pet_id'],
            special_needs_fee: pet['special_needs_fee']
          })
        end
      end
    end

    booking
  end

  def update_with_all(booking:, booking_pens:)
    errors = []
    
    self.update(booking)
    
    if self.valid?
      remove_pen_ids = self.booking_pens.map{|booking_pen| booking_pen.id} - booking_pens.map{|booking_pen| booking_pen[:id]}
      remove_pen_ids.each{|id| BookingPen.find(id).destroy}

      booking_pens.each do |pen|
        
        booking_pen = BookingPen.find_by(id: pen[:id])

        if booking_pen 
          
          booking_pen.update(
            pen_type_id: pen['pen_type_id'],
            pen_id: pen['pen_id'],
            rate_id: pen['rate_id']
          )

          remove_pet_ids = booking_pen.booking_pen_pets.map{|booking_pet| booking_pet[:id]} - pen[:booking_pen_pets].map{|booking_pet| booking_pet[:id]}
          remove_pet_ids.each{|id| BookingPenPet.find(id).destroy}

          pen['booking_pen_pets'].each do |pet|
            booking_pet = BookingPenPet.find_by(id: pet[:id])

            if booking_pet
              booking_pet.update(
                pet_id: pet['pet_id'],
                special_needs_fee: pet['special_needs_fee']
              )
            else 
              BookingPenPet.find_or_create_by({
                booking_pen: booking_pen,
                pet_id: pet['pet_id'],
                special_needs_fee: pet['special_needs_fee']
              })
            end
          end  

        else

          booking_pen = BookingPen.find_or_create_by({
            booking: self,
            pen_type_id: pen['pen_type_id'],
            pen_id: pen['pen_id'],
            rate_id: pen['rate_id']
          })

          pen['booking_pen_pets'].each do |pet|
            BookingPenPet.find_or_create_by({
              booking_pen: booking_pen,
              pet_id: pet['pet_id'],
              special_needs_fee: pet['special_needs_fee']
            })
          end
        end
      end
    end
    self
  end

  def self.daily_detail(date:)
    date = Date.parse(date)
    bookings = Booking.select{|booking| booking.booking_status != 'Cancelled' && booking.check_in <= date && booking.check_out >= date}
    todays_pens = bookings.reject{|booking| booking.booking_status == 'Completed'}.map{|booking| booking.booking_pens}.flatten

    {
      todays_pens: 
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
        end.to_h,

      available_pens: BookingPen.available_pens(
        check_in: date, 
        check_out: bookings.select{|booking| booking.check_in <= date+1 && ['Active', 'Reservation'].include?(booking.booking_status.name) && booking.check_out > date}.map{|booking| booking.check_out}.max || date, 
        pen_type_id: PenType.find_by(name: 'Dog Run').id
      ),
      today_pick_up: 
        {
          am: bookings.select{|booking| booking.check_out == date && booking.check_out_time == 'AM'}.map{|booking| booking.booking_detail},
          pm: bookings.select{|booking| booking.check_out == date && booking.check_out_time == 'PM'}.map{|booking| booking.booking_detail}
        },
      today_drop_off: 
        {
          am: bookings.select{|booking| booking.check_in == date && booking.check_in_time == 'AM'}.map{|booking| booking.booking_detail},
          pm: bookings.select{|booking| booking.check_in == date && booking.check_in_time == 'PM'}.map{|booking| booking.booking_detail}
        },
      tomorrow_drop_off: 
        {
          am: bookings.select{|booking| booking.check_in == date+1 && booking.check_in_time == 'AM'}.map{|booking| booking.booking_detail},
          pm: bookings.select{|booking| booking.check_in == date+1 && booking.check_in_time == 'PM'}.map{|booking| booking.booking_detail}
        }
    }
  end

  def booking_detail
    pets = self.booking_pens.map{|pen| pen.booking_pen_pets.map{|pet| {id: pet.pet.id, pet_type: pet.pet.pet_type.name, pet_name: pet.pet.name}}}.flatten
    dogs = pets.select{|pet| pet[:pet_type] == 'Dog'}.sort_by{|pet| pet[:id]}.map{|pet| pet[:pet_name]}
    cats = pets.select{|pet| pet[:pet_type] == 'Cat'}.sort_by{|pet| pet[:id]}.map{|pet| pet[:pet_name]}

    {
      id: self.id,
      check_in: self.check_in,
      check_in_time: self.check_in_time,
      check_out: self.check_out,
      check_out_time: self.check_out_time,
      owner_name: self.owner.name,
      status: self.booking_status.name,
      pens: self.booking_pens.sort_by{|pen| pen.id}.map{|pen| {
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
      pet_listing: '' + (dogs.length > 0 ? "#{dogs.length == 1 ? 'Dog' : 'Dogs'}: #{dogs.to_sentence}" : '') + (dogs.length > 0 && cats.length > 0 ? ', plus ' : '')  +  (cats.length > 0 ? "#{cats.length == 1 ? 'Cat' : 'Cats'}: #{cats.to_sentence}" : '')
    }
  end

  private

  def set_booking_ref
    self.booking_ref = Digest::SHA1.hexdigest(self.id.to_s)[8..16]
    self.save
  end
end
