class PetSociability < ApplicationRecord
  belongs_to :pet
  belongs_to :sociability

  def self.update_with_pet(pet:, sociabilities:)
    remove_sociability_ids = pet.pet_sociabilities.map{|sociability| sociability.id} - sociabilities.map{|sociability| sociability[:id]}
    remove_sociability_ids.each{|id| PetSociability.find(id).destroy}

    sociabilities.each do |sociability|
        
      pet_sociability = PetSociability.find_by(id: sociability[:id])

      if pet_sociability
        
        pet_sociability.update(
          sociability_id: sociability[:sociability_id], 
          inactive: sociability[:inactive]
        )

      else

        pet_sociability = PetSociability.find_or_create_by({
          pet: pet, 
          sociability_id: sociability[:sociability_id], 
          inactive: sociability[:inactive]
        })

      end
    end

      pet.reload
      
  end
end
