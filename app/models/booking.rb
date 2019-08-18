class Booking < ApplicationRecord
  belongs_to :owner
  belongs_to :booking_status
  has_many :booking_pens
  after_create :set_booking_ref

  def self.income_by_day(date:)
    date_bookings = Booking.select{|booking| booking.check_in <= date && (booking.check_out > date || (booking.check_out == date && booking.check_out_time == 'PM'))}
    date_bookings.map{|booking| booking.booking_pens}.flatten.map{|pen| pen.rate.amount.to_f}.reduce(:+) || 0
  end

  def self.income_by_month(month:, year:)
    range = (Date.parse("#{year}-#{month}-01")..(Date.parse("#{month.to_i == 12 ? (year.to_i + 1).to_s : year}-#{month.to_i == 12 ? 1 : month.to_i + 1}-01")-1)).to_a
    range.map{|date| Booking.income_by_day(date: date)}.reduce(:+)
  end

  def self.year_income_by_month(year:)
    months = ("#{year}-01-01".to_date.."#{year}-12-31".to_date).map(&:beginning_of_month).uniq
    months.map{|month| {month: month.strftime('%B'), amount: Booking.income_by_month(month: month.strftime('%m'), year: year)}}
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
      remove_pen_ids = booking.booking_pens.map{|booking_pen| booking_pen.id} - booking_pens.map{|booking_pen| booking_pen[:id]}
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
    {
      todays_pens: BookingPen.daily_detail(date: date),
      today_pick_up: 
        {
          am: Booking.select{|booking| booking.check_out == Date.parse(date) && booking.check_out_time == 'AM'}.map{|booking| booking.booking_detail},
          pm: Booking.select{|booking| booking.check_out === Date.parse(date) && booking.check_out_time == 'PM'}.map{|booking| booking.booking_detail}
        },
      today_drop_off: 
        {
          am: Booking.select{|booking| booking.check_in == Date.parse(date) && booking.check_in_time == 'AM'}.map{|booking| booking.booking_detail},
          pm: Booking.select{|booking| booking.check_in == Date.parse(date) && booking.check_in_time == 'PM'}.map{|booking| booking.booking_detail}
        },
      tomorrow_drop_off: 
        {
          am: Booking.select{|booking| booking.check_in == Date.parse(date)+1 && booking.check_in_time == 'AM'}.map{|booking| booking.booking_detail},
          pm: Booking.select{|booking| booking.check_in == Date.parse(date)+1 && booking.check_in_time == 'PM'}.map{|booking| booking.booking_detail}
        }
    }
  end

  def booking_detail
    pets = self.booking_pens.map{|pen| pen.booking_pen_pets.map{|pet| {pet_type: pet.pet.pet_type.name, pet_name: pet.pet.name}}}.flatten
    dogs = pets.select{|pet| pet[:pet_type] == 'Dog'}.map{|pet| pet[:pet_name]}
    cats = pets.select{|pet| pet[:pet_type] == 'Cat'}.map{|pet| pet[:pet_name]}

    {
      id: self.id,
      check_in: self.check_in,
      check_in_time: self.check_in_time,
      check_out: self.check_out,
      check_out_time: self.check_out_time,
      owner_name: self.owner.name,
      pens: self.booking_pens.map{|pen| {pen_type: pen.pen_type.name, pet_type: pen.pen_type.pet_type.name, pets: pen.booking_pen_pets.map{|pet| pet.pet.name}.to_sentence}},
      pet_listing: '' + (dogs.length > 0 ? "#{dogs.length == 1 ? 'Dog' : 'Dogs'}: #{dogs.to_sentence}" : '') + (dogs.length > 0 && cats.length > 0 ? ', plus ' : '')  +  (cats.length > 0 ? "#{cats.length == 1 ? 'Cat' : 'Cats'}: #{cats.to_sentence}" : '')
    }
  end

  private

  def set_booking_ref
    self.booking_ref = Digest::SHA1.hexdigest(self.id.to_s)[8..16]
    self.save
  end
end
