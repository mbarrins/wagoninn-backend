class PetIssue < ApplicationRecord
  belongs_to :pet
  belongs_to :issue

  def self.update_with_pet(pet:, issues:)
    remove_issue_ids = pet.pet_issues.map{|issue| issue.id} - issues.map{|issue| issue[:id]}
    remove_issue_ids.each{|id| PetIssue.find(id).destroy}

    issues.each do |issue|
        
      pet_issue = PetIssue.find_by(id: issue[:id])

      if pet_issue
        
        pet_issue.update(
          issue_id: issue[:issue_id], 
          inactive: issue[:inactive]
        )

      else

        pet_issue = PetIssue.find_or_create_by({
          pet: pet, 
          issue_id: issue[:issue_id], 
          inactive: issue[:inactive]
        })

      end
    end

      pet.reload
      
  end
end
