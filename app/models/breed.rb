class Breed < ApplicationRecord
  has_many :pets

  def self.api_info
    Breed.all.map{|breed| {id: breed.id, breed: breed.breed, banned: breed.banned}}
  end
end
