class PetSpecialNeed < ApplicationRecord
  belongs_to :pet
  belongs_to :special_need

  def self.update_with_pet(pet:, special_needs:)
    remove_special_need_ids = pet.pet_special_needs.map{|special_need| special_need.id} - special_needs.map{|special_need| special_need[:id]}
    remove_special_need_ids.each{|id| PetSpecialNeed.find(id).destroy}

    special_needs.each do |special_need|
        
      pet_special_need = PetSpecialNeed.find_by(id: special_need[:id])

      if pet_special_need
        
        pet_special_need.update(
          special_need_id: special_need[:special_need_id], 
          inactive: special_need[:inactive]
        )

      else

        pet_special_need = PetSpecialNeed.find_or_create_by({
          pet: pet, 
          special_need_id: special_need[:special_need_id], 
          inactive: special_need[:inactive]
        })

      end
    end

      pet.reload
      
  end
end
