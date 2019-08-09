class Pet < ApplicationRecord
  belongs_to :owner
  belongs_to :pet_type
  belongs_to :sex
  belongs_to :color, optional: true
  belongs_to :size
  belongs_to :breed, optional: true
  has_many :pet_immunisations
  has_many :pet_health_details
  has_many :pet_special_needs
  has_many :pet_medications
  has_many :pet_sociabilities
  has_many :pet_issues

end
