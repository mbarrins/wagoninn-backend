class Size < ApplicationRecord
  has_many :pets
  delegate :size, :to => :pet
end
