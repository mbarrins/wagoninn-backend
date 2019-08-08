class OwnerConcern < ApplicationRecord
  belongs_to :owner
  belongs_to :concerns
end
