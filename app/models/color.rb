class Color < ApplicationRecord
  has_many :pets
  delegate :color, :to => :pet
end
