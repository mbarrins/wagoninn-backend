class PetFood < ApplicationRecord
  belongs_to :pet
  belongs_to :food
  belongs_to :schedule
  belongs_to :measure

  def self.update_with_pet(pet:, foods:)
    remove_food_ids = pet.pet_foods.map{|food| food.id} - foods.map{|food| food[:id]}
    remove_food_ids.each{|id| PetFood.find(id).destroy}

    foods.each do |food|
        
      pet_food = PetFood.find_by(id: food[:id])

      if pet_food
        
        pet_food.update(
          food_id: food[:food_id], 
          quantity: food[:quantity], 
          measure_id: food[:measure_id], 
          schedule_id: food[:schedule_id]
        )

      else

        pet_food = PetFood.find_or_create_by({
          pet: pet, 
          food_id: food[:food_id], 
          quantity: food[:quantity], 
          measure_id: food[:measure_id], 
          schedule_id: food[:schedule_id]
        })

      end
    end

      pet.reload
      
  end
end
