class CreatePetImmunisations < ActiveRecord::Migration[5.2]
  def change
    create_table :pet_immunisations do |t|
      t.references :pet, foreign_key: true
      t.references :immunisation, foreign_key: true
      t.references :validity, foreign_key: true
      t.date :effective_date
      t.date :expiry_date

      t.timestamps
    end
  end
end
