class CreateHouseholdPeople < ActiveRecord::Migration[5.2]
  def change
    create_table :household_people do |t|
      t.references :household, foreign_key: true
      t.references :person, foreign_key: true
      t.references :person_type, foreign_key: true

      t.timestamps
    end
  end
end
