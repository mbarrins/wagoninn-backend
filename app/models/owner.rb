class Owner < ApplicationRecord
  has_many :pets
  has_many :owner_concerns

  def as_json(options={})
    super(options).reject { |k, v| v.nil? }
  end
end
