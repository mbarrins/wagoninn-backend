class CreateHouseholdPenPets < ActiveRecord::Migration[5.2]
  def change
    create_table :household_pen_pets do |t|
      t.references :household_pen, foreign_key: true
      t.references :pet, foreign_key: true
      t.references :rate, foreign_key: true

      t.timestamps
    end
  end
end
