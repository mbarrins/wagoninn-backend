class Owner < ApplicationRecord
  has_many :pets
  has_many :bookings
  has_many :owner_concerns

  def as_json(options={})
    super(options).map{|k,v| [k, v === nil ? '' : v]}.to_h
  end

  def name
    self.first_name + ' ' + self.last_name
  end
  
end
