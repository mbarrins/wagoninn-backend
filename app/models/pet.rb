class Pet < ApplicationRecord
  belongs_to :pet_type
  belongs_to :sex
  belongs_to :color
  belongs_to :size
  belongs_to :breed
  has_many :pet_immunisations
  has_many :pet_health_details
  has_many :pet_special_needs
  has_many :pet_medications
  has_many :pet_sociabilities
  has_many :pet_concerns
end
