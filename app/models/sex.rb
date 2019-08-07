class Sex < ApplicationRecord
  has_many :pets
  delegate :sex, :to => :pet
end
