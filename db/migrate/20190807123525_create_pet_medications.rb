class CreatePetMedications < ActiveRecord::Migration[5.2]
  def change
    create_table :pet_medications do |t|
      t.references :pet, foreign_key: true
      t.references :medication, foreign_key: true
      t.references :dose, foreign_key: true
      t.integer :dose_quantity
      t.references :schedule, foreign_key: true
      t.date :effective_from
      t.date :effective_to

      t.timestamps
    end
  end
end
