class OwnerPen < ApplicationRecord
  belongs_to :owner
  belongs_to :pen_type
end
