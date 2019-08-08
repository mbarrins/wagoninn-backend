class PetIssues < ApplicationRecord
  belongs_to :pet
  belongs_to :issues
end
