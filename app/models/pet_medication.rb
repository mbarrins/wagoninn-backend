class PetMedication < ApplicationRecord
  belongs_to :pet
  belongs_to :medication
  belongs_to :dose
  belongs_to :schedule

  def self.update_with_pet(pet:, medications:)
    remove_medication_ids = pet.pet_medications.map{|medication| medication.id} - medications.map{|medication| medication[:id]}
    remove_medication_ids.each{|id| PetMedication.find(id).destroy}

    medications.each do |medication|
        
      pet_medication = PetMedication.find_by(id: medication[:id])

      if pet_medication
        
        pet_medication.update(
          medication_id: medication[:medication_id], 
          dose_quantity: medication[:dose_quantity], 
          dose_id: medication[:dose_id], 
          schedule_id: medication[:schedule_id]
        )

      else

        pet_medication = PetMedication.find_or_create_by({
          pet: pet, 
          medication_id: medication[:medication_id], 
          dose_quantity: medication[:dose_quantity], 
          dose_id: medication[:dose_id], 
          schedule_id: medication[:schedule_id]
        })

      end
    end

      pet.reload
      
  end
end
