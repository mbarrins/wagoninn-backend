class PetSpecialNeed < ApplicationRecord
  belongs_to :pet
  belongs_to :special_need
end
