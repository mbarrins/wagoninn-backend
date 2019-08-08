class HouseholdConcern < ApplicationRecord
  belongs_to :household
  belongs_to :concerns
end
