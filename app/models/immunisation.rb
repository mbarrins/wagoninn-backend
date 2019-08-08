class Immunisation < ApplicationRecord
  belongs_to :pet_type

  def self.api_info
    {
      dog: Immunisation.select{|shot| shot.current && shot.pet_type === PetType.find_by(name: 'Dog')}.map{|shot| {id: shot.id, name: shot.name}},
      cat: Immunisation.select{|shot| shot.current && shot.pet_type === PetType.find_by(name: 'Cat')}.map{|shot| {id: shot.id, name: shot.name}}
    }
    
  end
end
