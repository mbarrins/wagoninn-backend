class HouseholdPerson < ApplicationRecord
  belongs_to :household
  belongs_to :person
  belongs_to :person_type
end
