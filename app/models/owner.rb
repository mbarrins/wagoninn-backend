class Owner < ApplicationRecord
  has_many :pets
  has_many :bookings
  has_many :owner_concerns

  def as_json(options={})
    super(options).map{|k,v| [k, v === nil ? '' : v]}.to_h
  end

  def name
    self.first_name + ' ' + self.last_name
  end

  def self.search(query:)
    Owner.all.select do |owner| 
      owner.first_name.downcase.include?(query.downcase) || 
      owner.last_name.downcase.include?(query.downcase) ||
      owner.partner_name.downcase.include?(query.downcase) ||
      owner.pets.any?{|pet| pet.name.downcase.include?(query.downcase)}
    end.map do |owner|
      owner_hash = {
        id: owner.id, 
        name: owner.name,
        partner: owner.partner_name,
        pets: owner.pets.map{|pet| "#{pet.name} (#{pet.pet_type_id == PetType.find_by(name: 'Dog').id ? pet.breed.name : pet.color.name})"}.to_sentence
      }

      if (owner.bookings.select{|booking| booking.check_out >= Date.today}.length > 0)
        owner_hash[:current_bookings] =  owner.bookings.select{|booking| booking.check_out >= Date.today}.sort_by{|booking| booking.check_out}.map{|booking| "#{booking.check_in.strftime('%d-%b-%Y')} to #{booking.check_out.strftime('%d-%b-%Y')}"}
      end

      if (owner.bookings.select{|booking| booking.check_out < Date.today}.length > 0)
        last_booking = owner.bookings.select{|booking| booking.check_out < Date.today}.max_by{|booking| booking.check_out}
        owner_hash[:last_stay] = "#{last_booking.check_in.strftime('%d-%b-%Y')} to #{last_booking.check_out.strftime('%d-%b-%Y')}"
      end

      owner_hash
    end
  end
  
end
