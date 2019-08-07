class HouseholdPen < ApplicationRecord
  belongs_to :household
  belongs_to :pen_type
end
