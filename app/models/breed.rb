class Breed < ApplicationRecord
  has_many :pets

  def self.api_info
    Breed.all.map{|breed| {id: breed.id, name: breed.name, banned: breed.banned}}
  end
end
