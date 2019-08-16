class PetHealthDetail < ApplicationRecord
  belongs_to :pet
  belongs_to :health_detail

  def self.update_with_pet(pet:, health_details:)
    remove_health_detail_ids = pet.pet_health_details.map{|health_detail| health_detail.id} - health_details.map{|health_detail| health_detail[:id]}
    remove_health_detail_ids.each{|id| PetHealthDetail.find(id).destroy}

    health_details.each do |health_detail|
        
      pet_health_detail = PetHealthDetail.find_by(id: health_detail[:id])

      if pet_health_detail
        
        pet_health_detail.update(
          health_detail_id: health_detail[:health_detail_id], 
          inactive: health_detail[:inactive]
        )

      else

        pet_health_detail = PetHealthDetail.find_or_create_by({
          pet: pet, 
          health_detail_id: health_detail[:health_detail_id], 
          inactive: health_detail[:inactive]
        })

      end
    end

      pet.reload
      
  end
end
