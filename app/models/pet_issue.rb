class PetIssue < ApplicationRecord
  belongs_to :pet
  belongs_to :issue
end
