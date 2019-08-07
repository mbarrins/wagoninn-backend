class HouseholdCare < ApplicationRecord
  belongs_to :household
  belongs_to :cares
end
