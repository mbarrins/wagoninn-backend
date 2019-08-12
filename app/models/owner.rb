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
      {
        id: owner.id, 
        name: owner.name,
        partner: owner.partner_name,
        pets: owner.pets.map{|pet| {pet_id: pet.id, name: pet.name, desc: pet.pet_type_id == PetType.find_by(name: 'Dog').id ? pet.breed.name : pet.color.name}}
      }
    end
  end
  
end
