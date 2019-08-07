class Phone < ApplicationRecord
  belongs_to :phone_type
  belongs_to :person
end
