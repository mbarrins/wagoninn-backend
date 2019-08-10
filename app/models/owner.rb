class Owner < ApplicationRecord
  has_many :pets
  has_many :owner_concerns

  def as_json(options={})
    super(options).map{|k,v| [k, v || '']}.to_h
  end
end
