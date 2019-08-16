class Pet < ApplicationRecord
  belongs_to :owner
  belongs_to :pet_type
  belongs_to :sex
  belongs_to :color, optional: true
  belongs_to :size
  belongs_to :breed, optional: true
  has_many :pet_foods
  has_many :pet_health_details
  has_many :pet_immunisations
  has_many :pet_issues
  has_many :pet_medications
  has_many :pet_sociabilities
  has_many :pet_special_needs

  def as_json(options={})
    super(options).map{|k,v| [k, v === nil ? '' : v]}.to_h
  end
  
  def self.create_with_all(pet:, immunisations:, foods:, health_details:, special_needs:, medications:, sociabilities:, issues:)
    
    pet = Pet.find_or_create_by(pet)
    
    if pet.valid?
      
      immunisations.each do |shot|
        PetImmunisation.create({
          pet: pet, 
          immunisation_id: shot[:immunisation_id], 
          validity_id: shot[:validity_id], 
          effective_date: shot[:effective_date], 
          expiry_date: shot[:expiry_date]
        })
      end

      foods.each do |food|
        PetFood.find_or_create_by({
          pet: pet, 
          food_id: food[:food_id], 
          quantity: food[:quantity], 
          measure_id: food[:measure_id], 
          schedule_id: food[:schedule_id]
        })
      end

      health_details.each do |health_detail|
        PetHealthDetail.find_or_create_by({
          pet: pet, 
          health_detail_id: health_detail[:health_detail_id], 
          inactive: health_detail[:inactive]
        })
      end

      special_needs.each do |special_need|
        PetSpecialNeed.find_or_create_by({
          pet: pet, 
          special_need_id: special_need[:special_need_id], 
          inactive: special_need[:inactive]
        })
      end

      medications.each do |medication|
        PetMedication.find_or_create_by({
          pet: pet, 
          medication_id: medication[:medication_id], 
          dose_quantity: medication[:dose_quantity], 
          dose_id: medication[:dose_id], 
          schedule_id: medication[:schedule_id]
        })
      end

      sociabilities.each do |sociability|
        PetSociability.find_or_create_by({
          pet: pet, 
          sociability_id: sociability[:sociability_id], 
          inactive: sociability[:inactive]
        })
      end

      issues.each do |issue|
        PetIssue.find_or_create_by({
          pet: pet, 
          issue_id: issue[:issue_id], 
          inactive: issue[:inactive]
        })
      end

    end

    pet

  end

  def update_with_all(pet:, immunisations:, foods:, health_details:, special_needs:, medications:, sociabilities:, issues:)
    self.update(pet)
    
    if self.valid?
      PetImmunisation.update_with_pet(pet: self, immunisations: immunisations)
      PetFood.update_with_pet(pet: self, foods: foods)
      PetHealthDetail.update_with_pet(pet: self, health_details: health_details)
      PetSpecialNeed.update_with_pet(pet: self, special_needs: special_needs)
      PetMedication.update_with_pet(pet: self, medications: medications)
      PetSociability.update_with_pet(pet: self, sociabilities: sociabilities)
      PetIssue.update_with_pet(pet: self, issues: issues)
    end

    self

  end

  def api_info
      {
        id: self.id, 
        owner_id: self.owner_id,
        pet_type_id: self.pet_type_id,
        name: self.name, 
        dob: self.dob,
        sex_id: self.sex_id,
        breed_id: self.breed_id,
        color_id: self.color_id,
        size_id: self.size_id,
        spayed_neutered: self.spayed_neutered,
        notes: self.notes,
        special_needs_fee: self.special_needs_fee,
        no_return: self.no_return,
        inactive: self.inactive,
        foods: self.pet_foods.map do |food|
          {
            id: food.id,
            pet_id: food.pet_id,
            food_id: food.food_id,
            quantity: food.quantity,
            measure_id: food.measure_id,
            schedule_id: food.schedule_id
          }
        end,
        health_details: self.pet_health_details.map do |health|
          {
            id: health.id,
            pet_id: health.pet_id,
            health_detail_id: health.health_detail_id,
            inactive: health.inactive
          }
        end,
        immunisations: self.pet_immunisations.map do |shot| 
          {
            id: shot.id, 
            pet_id: shot.pet_id, 
            immunisation_id: shot.immunisation_id, 
            validity_id: shot.validity_id,
            effective_date: shot.effective_date,
            expiry_date: shot.expiry_date
          }
        end,
        issues: self.pet_issues,
        medications: self.pet_medications,
        sociabilities: self.pet_sociabilities,
        special_needs: self.pet_special_needs
      }
  end
end
