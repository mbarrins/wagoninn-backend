class PetHealthDetail < ApplicationRecord
  belongs_to :pet
  belongs_to :health_detail
end
