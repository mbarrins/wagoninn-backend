class PetImmunisation < ApplicationRecord
  belongs_to :pet
  belongs_to :immunisation
  belongs_to :validity, optional: true

  def self.update_with_pet(pet:, immunisations:)
    remove_immunisation_ids = pet.pet_immunisations.map{|immunisation| immunisation.id} - immunisations.map{|immunisation| immunisation[:id]}
    remove_immunisation_ids.each{|id| PetImmunisation.find(id).destroy}

    immunisations.each do |shot|
        
      pet_shot = PetImmunisation.find_by(id: shot[:id])

      if pet_shot
        
        pet_shot.update(
          immunisation_id: shot[:immunisation_id], 
          validity_id: shot[:validity_id], 
          effective_date: shot[:effective_date], 
          expiry_date: shot[:expiry_date]
        )

      else

        pet_shot = PetImmunisation.find_or_create_by({
          pet: pet,
          immunisation_id: shot[:immunisation_id], 
          validity_id: shot[:validity_id], 
          effective_date: shot[:effective_date], 
          expiry_date: shot[:expiry_date]
        })

      end
    end

      pet.reload

  end
end
