class Employee < ApplicationRecord
  has_one :user, :as => :person
  belongs_to :employee_type

  validates :first_name, :last_name, :email, presence: true
end
